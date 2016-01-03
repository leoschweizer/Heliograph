#import "OCInstanceVariableMirror.h"


@implementation OCInstanceVariableMirror

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable {
	if (self = [super init]) {
		_mirroredInstanceVariable = instanceVariable;
		_definingClass = definingClass;
		_name = [NSString stringWithUTF8String:ivar_getName(_mirroredInstanceVariable)];
	}
	return self;
}

@end
