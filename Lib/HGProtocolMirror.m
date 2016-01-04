#import "HGProtocolMirror.h"


@implementation HGProtocolMirror

- (instancetype)initWithProtocol:(Protocol *)aProtocol {
	if (self = [super init]) {
		_mirroredProtocol = aProtocol;
	}
	return self;
}

@end
