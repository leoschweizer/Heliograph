#import <Foundation/Foundation.h>


@class HGMethodDescriptionMirror;


@interface HGProtocolMirror : NSObject <NSCopying>

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
 * Adds an incorporated protocol to the receiver's mirrored protocol. 
 * The protocol being added to must still be under construction, while the 
 * additional protocol must be already constructed.
 * @return a HGProtocolMirror reflecting the newly adopted protocol if successfull.
 */
- (HGProtocolMirror *)adoptProtocol:(Protocol *)aProtocol;

/**
 * Anserts an HGMethodDescriptionMirror reflecting the class method named
 * aName, if it exists.
 */
- (HGMethodDescriptionMirror *)classMethodNamed:(SEL)aName;

/**
 * Answers an NSArray of HGMethodDescriptionMirrors reflecting the class methods
 * defined by the receiver's mirrored protocol.
 */
- (NSArray *)classMethods;

/**
 * Answers the name of the receiver's mirrored protocol;
 */
- (NSString *)name;

/**
 * Anserts an HGMethodDescriptionMirror reflecting the instance method named
 * aName, if it exists.
 */
- (HGMethodDescriptionMirror *)instanceMethodNamed:(SEL)aName;

/**
 * Answers an NSArray of HGMethodDescriptionMirrors reflecting the instance 
 * methods defined by the receiver's mirrored protocol.
 */
- (NSArray *)instanceMethods;

/**
 * Answers an NSArray of HGPropertyMirrors reflecting the properties defined by
 * the receiver's mirrored protocol.
 */
- (NSArray *)properties;

/**
 * Registeres the receiver's mirrored protocol. Call this after creating a new 
 * protocol to finalize the protocol creation process.
 */
- (void)registerProtocol;

/**
 * Compares the receiving HGProtocolMirror to another HGProtocolMirror.
 * @returns YES if the mirrored protocol of aProtocolMirror is euqal to the 
 * receiver's mirrored protocol.
 */
- (BOOL)isEqualToProtocolMirror:(HGProtocolMirror *)aProtocolMirror;

@end
