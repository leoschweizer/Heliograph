#import "HGValueMirrors.h"
#import "HGClassMirror.h"


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
	return [[[self classMirror] type] methods];
}

- (HGClassMirror *)classMirror {
	return [[HGClassMirror alloc] initWithClass:[self.mirroredObject class]];
}

- (NSDictionary *)instanceMethods {
	return [[self classMirror] methods];
}

@end
