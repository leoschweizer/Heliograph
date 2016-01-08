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

/**
 * Answers an NSArray of HGMethodMirrors reflecting the instance methods defined
 * by the receiver's mirrored protocol.
 */
- (NSArray *)instanceMethods;

/**
 * Answers an NSArray of HGMethodMirrors reflecting the class methods defined
 * by the receiver's mirrored protocol.
 */
- (NSArray *)classMethods;

@end
