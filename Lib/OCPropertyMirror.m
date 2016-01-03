#import "OCPropertyMirror.h"
#import <objc/runtime.h>
#import "OCTypeMirrors.h"


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

static OCPropertyAttributes parseAttributes(NSArray *stringAttributes) {
	return OCPropertyAttributesNone |
		([stringAttributes containsObject:cPropertyAttributeReadonly] ? OCPropertyAttributesReadonly : 0) |
		([stringAttributes containsObject:cPropertyAttributeCopy] ? OCPropertyAttributesCopy :0 ) |
		([stringAttributes containsObject:cPropertyAttributeRetain] ? OCPropertyAttributesRetain : 0) |
		([stringAttributes containsObject:cPropertyAttributeNonatomic] ? OCPropertyAttributesNonatomic : 0) |
		([stringAttributes containsObject:cPropertyAttributeDynamic] ? OCPropertyAttributesDynamic : 0) |
		([stringAttributes containsObject:cPropertyAttributeWeak] ? OCPropertyAttributesWeak : 0) |
		([stringAttributes containsObject:cPropertyAttributeGarbageCollection] ? OCPropertyAttributesGarbageCollection : 0);
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


@interface OCPropertyMirror ()

@property (nonatomic, readonly) NSString *backingInstanceVariableName;

@end


@implementation OCPropertyMirror

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass property:(objc_property_t)aProperty {
	if (self = [super init]) {
		_mirroredProperty = aProperty;
		_definingClass = definingClass;
		NSArray *stringAttributes = parseStringAttributes(property_getAttributes(_mirroredProperty));
		_attributes = parseAttributes(stringAttributes);
		_name = [NSString stringWithUTF8String:property_getName(self.mirroredProperty)];
		_getterName = parseGetterName(stringAttributes, _name);
		_setterName = parseSetterName(stringAttributes, _name);
		_backingInstanceVariableName = parseBackingInstanceVariableName(stringAttributes);
	}
	return self;
}

- (OCInstanceVariableMirror *)backingInstanceVariable {
	if (!self.backingInstanceVariableName) {
		return nil;
	}
	NSDictionary *instanceVariables = [self.definingClass instanceVariables];
	return [instanceVariables objectForKey:self.backingInstanceVariableName];
}

- (BOOL)isCopied {
	return self.attributes & OCPropertyAttributesCopy;
}

- (BOOL)isDynamic {
	return self.attributes & OCPropertyAttributesDynamic;
}

- (BOOL)isNonatomic {
	return self.attributes & OCPropertyAttributesNonatomic;
}

- (BOOL)isReadonly {
	return self.attributes & OCPropertyAttributesReadonly;
}

- (BOOL)isRetained {
	return self.attributes & OCPropertyAttributesRetain;
}

- (BOOL)isWeak {
	return self.attributes & OCPropertyAttributesWeak;
}

- (BOOL)isGarbageCollected {
	return self.attributes & OCPropertyAttributesGarbageCollection;
}

@end
