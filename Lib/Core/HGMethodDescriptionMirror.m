#import "HGMethodDescriptionMirror.h"
#import "HGMethodDescriptionMirror-Runtime.h"


@interface HGMethodDescriptionMirror ()

@property (nonatomic, readonly) struct objc_method_description mirroredMethodDescription;

@end


@implementation HGMethodDescriptionMirror

- (instancetype)initWithDefiningProtocol:(HGProtocolMirror *)aProtocol methodDescription:(struct objc_method_description)aMethodDescription isRequired:(BOOL)isRequired isInstanceMethod:(BOOL)isInstanceMethod {
	if (self = [super init]) {
		_definingProtocol = aProtocol;
		_mirroredMethodDescription = aMethodDescription;
		_isRequired = isRequired;
		_isInstanceMethod = isInstanceMethod;
	}
	return self;
}

- (BOOL)isClassMethod {
	return !self.isInstanceMethod;
}

- (BOOL)isOptional {
	return !self.isRequired;
}

@end
