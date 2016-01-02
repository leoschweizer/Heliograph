#import "OCValueMirrors.h"
#import "OCTypeMirrors.h"


@implementation OCValueMirror

@end


@implementation OCObjectMirror

- (instancetype)initWithObject:(id)anObject {
	if (self = [super init]) {
		_mirroredObject = anObject;
	}
	return self;
}

- (NSDictionary *)classMethods {
	return [[[self classMirror] classMirror] methodDictionary];
}

- (OCClassMirror *)classMirror {
	return [[OCClassMirror alloc] initWithClass:[self.mirroredObject class]];
}

- (NSDictionary *)instanceMethods {
	return [[self classMirror] methodDictionary];
}

@end
