#import "HGPropertyMirror.h"
#import "HGPropertyMirror-Runtime.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"
#import "HGTypeMirrors.h"
#import "HGMethodMirror.h"


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

static id<HGTypeMirror> parseType(NSArray *stringAttributes) {
	NSString *attribute = [stringAttributes firstObject];
	NSCAssert([attribute hasPrefix:@"T"], @"encountered unexpected encoding");
	return [HGBaseTypeMirror createForEncoding:[attribute substringFromIndex:1]];
}


@interface HGPropertyMirror ()

@property (nonatomic, readonly) NSValue *mirroredPropertyStorage;
@property (nonatomic, readonly) NSString *backingInstanceVariableName;
@property (nonatomic, readonly) NSString *getterName;
@property (nonatomic, readonly) NSString *setterName;

@end


@implementation HGPropertyMirror

- (void)commonInitWithProperty:(objc_property_t)aProperty {
	_mirroredPropertyStorage = [NSValue valueWithBytes:&aProperty objCType:@encode(objc_property_t)];
	NSArray *stringAttributes = parseStringAttributes(property_getAttributes(self.mirroredProperty));
	_attributes = parseAttributes(stringAttributes);
	_getterName = parseGetterName(stringAttributes, self.name);
	_setterName = parseSetterName(stringAttributes, self.name);
	_backingInstanceVariableName = parseBackingInstanceVariableName(stringAttributes);
	_type = parseType(stringAttributes);
}

- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass property:(objc_property_t)aProperty {
	if (self = [super init]) {
		_definingClass = definingClass;
		[self commonInitWithProperty:aProperty];
	}
	return self;
}

- (instancetype)initWithDefiningProtocol:(id)definingProtocol property:(objc_property_t)aProperty {
	if (self = [super init]) {
		_definingProtocol = definingProtocol;
		[self commonInitWithProperty:aProperty];
	}
	return self;
}

- (HGInstanceVariableMirror *)backingInstanceVariable {
	NSAssert(self.definingClass, @"This method can only be called on properties with an associated class");
	if (!self.backingInstanceVariableName) {
		return nil;
	}
	return [self.definingClass instanceVariableNamed:self.backingInstanceVariableName];
}

- (HGMethodMirror *)getter {
	NSAssert(self.definingClass, @"This method can only be called on properties with an associated class");
	return [self.definingClass methodNamed:NSSelectorFromString(self.getterName)];
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

- (objc_property_t)mirroredProperty {
	objc_property_t result;
	[self.mirroredPropertyStorage getValue:&result];
	return result;
}

- (NSString *)name {
	return [NSString stringWithUTF8String:property_getName(self.mirroredProperty)];
}

- (HGMethodMirror *)setter {
	NSAssert(self.definingClass, @"This method can only be called on properties with an associated class");
	return [self.definingClass methodNamed:NSSelectorFromString(self.setterName)];
}

- (void)setValue:(id)aValue in:(id)anObject {
	[[self setter] invokeOn:anObject withArguments:@[aValue]];
}

- (id<HGValueMirror>)valueIn:(id)anObject {
	return [[self getter] invokeOn:anObject withArguments:@[]];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToPropertyMirror:anObject];
}

- (BOOL)isEqualToPropertyMirror:(HGPropertyMirror *)aPropertyMirror {
	return [self.mirroredPropertyStorage isEqual:aPropertyMirror.mirroredPropertyStorage];
}

- (NSUInteger)hash {
	return [@"HGPropertyMirror" hash] ^ [self.mirroredPropertyStorage hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGPropertyMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_mirroredPropertyStorage = [_mirroredPropertyStorage copyWithZone:zone];
	newMirror->_backingInstanceVariableName = [_backingInstanceVariableName copyWithZone:zone];
	newMirror->_getterName = [_getterName copyWithZone:zone];
	newMirror->_setterName = [_setterName copyWithZone:zone];
	return newMirror;
}

@end
