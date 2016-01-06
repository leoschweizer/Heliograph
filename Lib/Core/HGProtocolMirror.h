#import <Foundation/Foundation.h>


@interface HGProtocolMirror : NSObject

/**
 * Answers an NSArray of HGProtocolMirrors reflecting all the known protocols of
 * the current runtime environment.
 */
+ (NSArray *)allProtocols;

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
