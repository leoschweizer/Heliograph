#import "HGProtocolMirror.h"
#import <objc/runtime.h>


@implementation HGProtocolMirror

+ (NSArray *)allProtocols {
	unsigned int protocolCount;
	Protocol * __unsafe_unretained *protocols = objc_copyProtocolList(&protocolCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:protocolCount];
	for(int i = 0; i < protocolCount; i++) {
		[result addObject:[[self alloc] initWithProtocol:protocols[i]]];
	}
	free(protocols);
	return [NSArray arrayWithArray:result];
}

- (instancetype)initWithProtocol:(Protocol *)aProtocol {
	if (self = [super init]) {
		_mirroredProtocol = aProtocol;
	}
	return self;
}

- (NSArray *)adoptedProtocols {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int protocolCount = 0;
	Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(self.mirroredProtocol, &protocolCount);
	for (int i = 0; i < protocolCount; i++) {
		Protocol *protocol = protocols[i];
		HGProtocolMirror *mirror = [[HGProtocolMirror alloc] initWithProtocol:protocol];
		[result addObject:mirror];
	}
	free(protocols);
	return [NSArray arrayWithArray:result];
}

@end
