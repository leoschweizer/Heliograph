#import "HGMethodMirror.h"
#import <objc/runtime.h>
#import "HGTypeMirrors.h"


@implementation HGMethodMirror

- (instancetype)initWithDefiningClass:(HGClassMirror *)classMirror method:(Method)method {
	if (self = [super init]) {
		_definingClass = classMirror;
		_mirroredMethod = method;
	}
	return self;
}

- (NSArray *)argumentTypes {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int numberOfArguments = method_getNumberOfArguments(self.mirroredMethod);
	for (int i = 2; i < numberOfArguments; i++) {
		char *encoding = method_copyArgumentType(self.mirroredMethod, i);
		HGTypeMirror *mirror = [HGTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
		[result addObject:mirror];
		free(encoding);
	}
	return [NSArray arrayWithArray:result];
}

- (NSUInteger)numberOfArguments {
	// we don't want to take account of self and _cmd here, hence subtract 2
	return method_getNumberOfArguments(self.mirroredMethod) - 2;
}

- (SEL)selector {
	return method_getName(self.mirroredMethod);
}

- (HGTypeMirror *)returnType {
	char *encoding = method_copyReturnType(self.mirroredMethod);
	HGTypeMirror *mirror = [HGTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
	free(encoding);
	return mirror;
}

@end
