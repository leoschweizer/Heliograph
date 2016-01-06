#import "HGValueMirrors.h"
#import "HGClassMirror.h"
#import <objc/runtime.h>


@implementation HGValueMirror

@end


@implementation HGObjectMirror

- (instancetype)initWithObject:(id)anObject {
	if (self = [super init]) {
		_mirroredObject = anObject;
	}
	return self;
}

- (NSDictionary *)classMethods {
	return [[[self classMirror] classMirror] methods];
}

- (HGClassMirror *)classMirror {
	Class class = object_getClass(self.mirroredObject);
	return [[HGClassMirror alloc] initWithClass:class];
}

- (NSDictionary *)instanceMethods {
	return [[self classMirror] methods];
}

@end
