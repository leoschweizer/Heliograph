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

- (SEL)selector {
	return method_getName(self.mirroredMethod);
}

@end
