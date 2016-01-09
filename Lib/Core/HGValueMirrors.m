#import "HGValueMirrors.h"
#import "HGClassMirror.h"
#import <objc/runtime.h>


@implementation HGBaseValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {}

- (instancetype)initWithValue:(NSValue *)aValue {
	if (self = [super init]) {
		_mirroredValue = aValue;
	}
	return self;
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

@end


@implementation HGShortValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitShortValueMirror:)]) {
		[aVisitor visitShortValueMirror:self];
	}
}

@end


@implementation HGIntValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitIntValueMirror:)]) {
		[aVisitor visitIntValueMirror:self];
	}
}

@end


@implementation HGLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongValueMirror:)]) {
		[aVisitor visitLongValueMirror:self];
	}
}

@end


@implementation HGLongLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongLongValueMirror:)]) {
		[aVisitor visitLongLongValueMirror:self];
	}
}

@end


@implementation HGUnsignedCharValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedCharValueMirror:)]) {
		[aVisitor visitUnsignedCharValueMirror:self];
	}
}

@end


@implementation HGUnsignedShortValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedShortValueMirror:)]) {
		[aVisitor visitUnsignedShortValueMirror:self];
	}
}

@end


@implementation HGUnsignedIntValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedIntValueMirror:)]) {
		[aVisitor visitUnsignedIntValueMirror:self];
	}
}

@end


@implementation HGUnsignedLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongValueMirror:)]) {
		[aVisitor visitUnsignedLongValueMirror:self];
	}
}

@end


@implementation HGUnsignedLongLongValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongLongValueMirror:)]) {
		[aVisitor visitUnsignedLongLongValueMirror:self];
	}
}

@end


@implementation HGFloatValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitFloatValueMirror:)]) {
		[aVisitor visitFloatValueMirror:self];
	}
}

@end


@implementation HGDoubleValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitDoubleValueMirror:)]) {
		[aVisitor visitDoubleValueMirror:self];
	}
}

@end


@implementation HGBoolValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBoolValueMirror:)]) {
		[aVisitor visitBoolValueMirror:self];
	}
}

@end


@implementation HGCharacterStringValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitCharacterStringValueMirror:)]) {
		[aVisitor visitCharacterStringValueMirror:self];
	}
}

@end


@implementation HGSelectorValueMirror

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitSelectorValueMirror:)]) {
		[aVisitor visitSelectorValueMirror:self];
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
