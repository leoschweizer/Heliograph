#import <Foundation/Foundation.h>


@interface HGProtocolMirror : NSObject

@property (nonatomic, readonly) Protocol *mirroredProtocol;

- (instancetype)initWithProtocol:(Protocol *)aProtocol;

@end
