#import "HGValueMirrors.h"
#import "HGClassMirror.h"
#import <objc/runtime.h>
#import "HGValueMirrorDescriptionVisitor.h"


@implementation HGBaseValueMirror

- (instancetype)initWithValue:(NSValue *)aValue {
	if (self = [super init]) {
		_mirroredValue = aValue;
	}
	return self;
}

- (NSString *)valueDescription {
	HGValueMirrorDescriptionVisitor *visitor = [[HGValueMirrorDescriptionVisitor alloc] init];
	[self acceptValueMirrorVisitor:visitor];
	return visitor.valueDescription;
}

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToValueMirror:anObject];
}

- (BOOL)isEqualToValueMirror:(id<HGValueMirror>)aValueMirror {
	return [self.mirroredValue isEqual:((HGBaseValueMirror *)aValueMirror).mirroredValue];
}

- (NSUInteger)hash {
	return [@"HGValueMirror" hash] ^ [self.mirroredValue hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGBaseValueMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_mirroredValue = [_mirroredValue copyWithZone:zone];
	return newMirror;
}

@end


@interface HGObjectMirror ()

// NSValue will not retain the mirrored object, thus keep it alive by this
// otherwise unused strong reference.
@property (nonatomic, readonly) id strongObjectRef;

@end


@implementation HGObjectMirror

- (instancetype)initWithValue:(NSValue *)aValue {
	if (self = [super initWithValue:aValue]) {
		_strongObjectRef = [aValue nonretainedObjectValue];
	}
	return self;
}

- (instancetype)initWithObject:(id)anObject {
	if (self = [super initWithValue:[NSValue valueWithNonretainedObject:anObject]]) {
		_strongObjectRef = anObject;
	}
	return self;
}

- (id)mirroredObject {
	return [self.mirroredValue nonretainedObjectValue];
}

- (NSArray *)classMethods {
	return [[[self classMirror] classMirror] methods];
}

- (HGClassMirror *)classMirror {
	Class class = object_getClass(self.mirroredObject);
	return [[HGClassMirror alloc] initWithClass:class];
}

- (NSArray *)instanceMethods {
	return [[self classMirror] methods];
}

- (HGClassMirror *)type {
	return [self classMirror];
}

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitObjectValueMirror:)]) {
		[aVisitor visitObjectValueMirror:self];
	}
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGObjectMirror *newMirror = [super copyWithZone:zone];
	newMirror->_strongObjectRef = _strongObjectRef;
	return newMirror;
}

@end


@implementation HGCharValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitCharValueMirror:)]) {
		[aVisitor visitCharValueMirror:self];
	}
}

- (char)charValue {
	char result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGShortValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitShortValueMirror:)]) {
		[aVisitor visitShortValueMirror:self];
	}
}

- (short)shortValue {
	short result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGIntValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitIntValueMirror:)]) {
		[aVisitor visitIntValueMirror:self];
	}
}

- (int)intValue {
	int result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongValueMirror:)]) {
		[aVisitor visitLongValueMirror:self];
	}
}

- (long)longValue {
	long result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGLongLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongLongValueMirror:)]) {
		[aVisitor visitLongLongValueMirror:self];
	}
}

- (long long)longValue {
	return [self longLongValue];
}

- (long long)longLongValue {
	long long result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGUnsignedCharValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedCharValueMirror:)]) {
		[aVisitor visitUnsignedCharValueMirror:self];
	}
}

- (unsigned char)unsignedCharValue {
	unsigned char result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGUnsignedShortValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedShortValueMirror:)]) {
		[aVisitor visitUnsignedShortValueMirror:self];
	}
}

- (unsigned short)unsignedShortValue {
	unsigned short result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGUnsignedIntValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedIntValueMirror:)]) {
		[aVisitor visitUnsignedIntValueMirror:self];
	}
}

- (unsigned int)unsignedIntValue {
	unsigned int result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGUnsignedLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongValueMirror:)]) {
		[aVisitor visitUnsignedLongValueMirror:self];
	}
}

- (unsigned long)unsignedLongValue {
	unsigned long result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGUnsignedLongLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongLongValueMirror:)]) {
		[aVisitor visitUnsignedLongLongValueMirror:self];
	}
}

- (unsigned long long)unsignedLongValue {
	return [self unsignedLongLongValue];
}

- (unsigned long long)unsignedLongLongValue {
	unsigned long long result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGFloatValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitFloatValueMirror:)]) {
		[aVisitor visitFloatValueMirror:self];
	}
}

- (float)floatValue {
	float result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGDoubleValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitDoubleValueMirror:)]) {
		[aVisitor visitDoubleValueMirror:self];
	}
}

- (double)doubleValue {
	double result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGBoolValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBoolValueMirror:)]) {
		[aVisitor visitBoolValueMirror:self];
	}
}

- (bool)boolValue {
	_Bool result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGCharacterStringValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitCharacterStringValueMirror:)]) {
		[aVisitor visitCharacterStringValueMirror:self];
	}
}

- (char *)characterStringValue {
	char *result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGSelectorValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitSelectorValueMirror:)]) {
		[aVisitor visitSelectorValueMirror:self];
	}
}

- (SEL)selectorValue {
	SEL result;
	[self.mirroredValue getValue:&result];
	return result;
}

@end


@implementation HGArrayValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitArrayValueMirror:)]) {
		[aVisitor visitArrayValueMirror:self];
	}
}

- (void)readArrayValue:(void *)outArray {
	[self.mirroredValue getValue:outArray];
}

@end


@implementation HGStructureValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitStructureValueMirror:)]) {
		[aVisitor visitStructureValueMirror:self];
	}
}

- (void)readStructureValue:(void *)outStructure {
	[self.mirroredValue getValue:outStructure];
}

@end


@implementation HGUnionValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnionValueMirror:)]) {
		[aVisitor visitUnionValueMirror:self];
	}
}

- (void)readUnionValue:(void *)outUnion {
	[self.mirroredValue getValue:outUnion];
}

@end


@implementation HGBitFieldValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBitFieldValueMirror:)]) {
		[aVisitor visitBitFieldValueMirror:self];
	}
}

@end


@implementation HGVoidValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitVoidValueMirror:)]) {
		[aVisitor visitVoidValueMirror:self];
	}
}

@end


@implementation HGPointerValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitPointerValueMirror:)]) {
		[aVisitor visitPointerValueMirror:self];
	}
}

@end


@implementation HGUnknownValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnknownValueMirror:)]) {
		[aVisitor visitUnknownValueMirror:self];
	}
}

@end
