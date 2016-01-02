#import "OCClassMirror.h"


@implementation OCClassMirror

- (instancetype)initWithClass:(Class)aClass {
	if (self = [super init]) {
		_mirroredClass = aClass;
	}
	return self;
}

@end
