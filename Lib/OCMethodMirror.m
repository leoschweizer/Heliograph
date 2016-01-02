#import "OCMethodMirror.h"
#import <objc/runtime.h>


@implementation OCMethodMirror

- (instancetype)initWithDefiningClass:(OCClassMirror *)classMirror method:(Method)method {
	if (self = [super init]) {
		_definingClass = classMirror;
		_mirroredMethod = method;
	}
	return self;
}

- (NSUInteger)numberOfArguments {
	// we don't want to take account of self and _cmd here, hence subtract 2
	return method_getNumberOfArguments(self.mirroredMethod) - 2;
}

- (SEL)selector {
	return method_getName(self.mirroredMethod);
}

@end
