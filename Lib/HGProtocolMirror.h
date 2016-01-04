#import <Foundation/Foundation.h>


@interface HGProtocolMirror : NSObject

@property (nonatomic, readonly) Protocol *mirroredProtocol;

- (instancetype)initWithProtocol:(Protocol *)aProtocol;

/**
 * Answers an NSArray of OCProtocolMirrors reflecting the protocols adopted
 * by the receiver's mirrored protocol.
 */
- (NSArray *)adoptedProtocols;

@end
