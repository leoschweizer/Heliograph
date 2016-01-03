#import "OCInstanceVariableMirror.h"
#import "OCTypeMirrors.h"


@implementation OCInstanceVariableMirror

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable {
	if (self = [super init]) {
		_mirroredInstanceVariable = instanceVariable;
		_definingClass = definingClass;
		_name = [NSString stringWithUTF8String:ivar_getName(_mirroredInstanceVariable)];
	}
	return self;
}

- (OCTypeMirror *)type {
	const char *encoding = ivar_getTypeEncoding(self.mirroredInstanceVariable);
	return [OCTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
}

@end
