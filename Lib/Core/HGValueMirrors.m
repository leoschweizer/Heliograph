#import "HGValueMirrors.h"
#import "HGClassMirror.h"
#import <objc/runtime.h>
#import "HGValueMirrorDescriptionVisitor.h"


@implementation HGBaseValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {}

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

@end


@implementation HGObjectMirror

- (instancetype)initWithObject:(id)anObject {
	if (self = [super init]) {
		_mirroredObject = anObject;
	}
	return self;
}

- (NSValue *)mirroredValue {
	return [NSValue valueWithNonretainedObject:self.mirroredObject];
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
	char *result = *(char **)[self.mirroredValue pointerValue];
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

@end


@implementation HGStructureValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitStructureValueMirror:)]) {
		[aVisitor visitStructureValueMirror:self];
	}
}

@end


@implementation HGUnionValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnionValueMirror:)]) {
		[aVisitor visitUnionValueMirror:self];
	}
}

@end


@implementation HGBitFieldValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBitFieldValueMirror:)]) {
		[aVisitor visitBitFieldValueMirror:self];
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
