#import <Foundation/Foundation.h>


@interface HGProtocolMirror : NSObject

/**
 * The reflected protocol.
 */
@property (nonatomic, readonly) Protocol *mirroredProtocol;

/**
 * Answers an HGProtocolMirror instance reflecting aProtocol.
 */
- (instancetype)initWithProtocol:(Protocol *)aProtocol;

/**
 * Answers an NSArray of OCProtocolMirrors reflecting the protocols adopted
 * by the receiver's mirrored protocol.
 */
- (NSArray *)adoptedProtocols;

@end
