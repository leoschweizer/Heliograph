#import <Foundation/Foundation.h>


@interface HGProtocolMirror : NSObject

/**
 * Creates a new protocol with aName.
 * @return an HGProtocolMirror reflecting the newly created protocol.
 * @note the new protocol has to be finalized with a call to 
 *  [protocolMirror registerProtocol] and will be immutable after that.
 */
+ (HGProtocolMirror *)addProtocolNamed:(NSString *)aName;

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
 * Answers an NSArray of HGMethodDescriptionMirrors reflecting the class methods
 * defined by the receiver's mirrored protocol.
 */
- (NSArray *)classMethods;

/**
 * Answers an NSArray of HGMethodDescriptionMirrors reflecting the instance 
 * methods defined by the receiver's mirrored protocol.
 */
- (NSArray *)instanceMethods;

/**
 * Registeres the receiver's mirrored protocol. Call this after creating a new 
 * protocol to finalize the protocol creation process.
 */
- (void)registerProtocol;

@end
