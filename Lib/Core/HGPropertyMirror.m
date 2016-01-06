#import "HGPropertyMirror.h"
#import "HGPropertyMirror-Runtime.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"
#import "HGTypeMirrors.h"


static NSString * const cPropertyAttributeReadonly = @"R";
static NSString * const cPropertyAttributeCopy = @"C";
static NSString * const cPropertyAttributeRetain = @"&";
static NSString * const cPropertyAttributeNonatomic = @"N";
static NSString * const cPropertyAttributeDynamic = @"D";
static NSString * const cPropertyAttributeWeak = @"W";
static NSString * const cPropertyAttributeGarbageCollection = @"P";


static NSArray * parseStringAttributes(const char * attributes) {
	NSString *result = [NSString stringWithUTF8String:attributes];
	// The string starts with a T followed by the @encode type and a comma,
	// and finishes with a V followed by the name of the backing instance
	// variable. Between these, the attributes are separated by commas.
	return [result componentsSeparatedByString:@","];
}

static HGPropertyAttributes parseAttributes(NSArray *stringAttributes) {
	return HGPropertyAttributesNone |
		([stringAttributes containsObject:cPropertyAttributeReadonly] ? HGPropertyAttributesReadonly : 0) |
		([stringAttributes containsObject:cPropertyAttributeCopy] ? HGPropertyAttributesCopy :0 ) |
		([stringAttributes containsObject:cPropertyAttributeRetain] ? HGPropertyAttributesRetain : 0) |
		([stringAttributes containsObject:cPropertyAttributeNonatomic] ? HGPropertyAttributesNonatomic : 0) |
		([stringAttributes containsObject:cPropertyAttributeDynamic] ? HGPropertyAttributesDynamic : 0) |
		([stringAttributes containsObject:cPropertyAttributeWeak] ? HGPropertyAttributesWeak : 0) |
		([stringAttributes containsObject:cPropertyAttributeGarbageCollection] ? HGPropertyAttributesGarbageCollection : 0);
}


static NSString *parseGetterName(NSArray *stringAttributes, NSString *propertyName) {
	for (NSString *attribute in stringAttributes) {
		if ([attribute hasPrefix:@"G"]) {
			return [attribute substringFromIndex:1];
		}
	}
	return [propertyName copy];
}

static NSString *parseSetterName(NSArray *stringAttributes, NSString *propertyName) {
	for (NSString *attribute in stringAttributes) {
		if ([attribute hasPrefix:@"S"]) {
			return [attribute substringFromIndex:1];
		}
	}
	return [NSString stringWithFormat:@"set%@:", [propertyName capitalizedString]];
}

static NSString *parseBackingInstanceVariableName(NSArray *stringAttributes) {
	NSString *attribute = [stringAttributes lastObject];
	if (![attribute hasPrefix:@"V"]) {
		return nil;
	}
	return [attribute substringFromIndex:1];
}

static HGTypeMirror *parseType(NSArray *stringAttributes) {
	NSString *attribute = [stringAttributes firstObject];
	if (![attribute hasPrefix:@"T"]) {
		return nil;
	}
	return [HGTypeMirror createForEncoding:[attribute substringFromIndex:1]];
}


@interface HGPropertyMirror ()

@property (nonatomic, readonly) objc_property_t mirroredProperty;
@property (nonatomic, readonly) NSString *backingInstanceVariableName;
@property (nonatomic, readonly) NSString *getterName;
@property (nonatomic, readonly) NSString *setterName;

@end


@implementation HGPropertyMirror

- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass property:(objc_property_t)aProperty {
	if (self = [super init]) {
		_mirroredProperty = aProperty;
		_definingClass = definingClass;
		NSArray *stringAttributes = parseStringAttributes(property_getAttributes(_mirroredProperty));
		_attributes = parseAttributes(stringAttributes);
		_name = [NSString stringWithUTF8String:property_getName(self.mirroredProperty)];
		_getterName = parseGetterName(stringAttributes, _name);
		_setterName = parseSetterName(stringAttributes, _name);
		_backingInstanceVariableName = parseBackingInstanceVariableName(stringAttributes);
		_type = parseType(stringAttributes);
	}
	return self;
}

- (HGInstanceVariableMirror *)backingInstanceVariable {
	if (!self.backingInstanceVariableName) {
		return nil;
	}
	return [self.definingClass instanceVariableNamed:self.backingInstanceVariableName];
}

- (HGMethodMirror *)getter {
	NSDictionary *methods = [self.definingClass methods];
	return [methods objectForKey:self.getterName];
}

- (BOOL)isCopied {
	return self.attributes & HGPropertyAttributesCopy;
}

- (BOOL)isDynamic {
	return self.attributes & HGPropertyAttributesDynamic;
}

- (BOOL)isNonatomic {
	return self.attributes & HGPropertyAttributesNonatomic;
}

- (BOOL)isReadonly {
	return self.attributes & HGPropertyAttributesReadonly;
}

- (BOOL)isRetained {
	return self.attributes & HGPropertyAttributesRetain;
}

- (BOOL)isWeak {
	return self.attributes & HGPropertyAttributesWeak;
}

- (BOOL)isGarbageCollected {
	return self.attributes & HGPropertyAttributesGarbageCollection;
}

- (HGMethodMirror *)setter {
	NSDictionary *methods = [self.definingClass methods];
	return [methods objectForKey:self.setterName];
}

@end
