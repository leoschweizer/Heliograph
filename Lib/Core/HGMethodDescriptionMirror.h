#import <Foundation/Foundation.h>


@class HGProtocolMirror;
@class HGTypeMirror;


@interface HGMethodDescriptionMirror : NSObject

/**
 * The HGProtocolMirror reflecting the receiver's mirrored method description's
 * defining protocol.
 */
@property (nonatomic, readonly) HGProtocolMirror *definingProtocol;

/**
 * Answers YES if the receiver's mirrored method description is a class method.
 */
@property (nonatomic, readonly) BOOL isClassMethod;

/**
 * Answers YES if the receiver's mirrored method description is an instance
 * method.
 */
@property (nonatomic, readonly) BOOL isInstanceMethod;

/**
 * Answers YES if the receiver's mirrored method description is defined as
 * @required.
 */
@property (nonatomic, readonly) BOOL isRequired;

/**
 * Answers YES if the receiver's mirrored method description is defined as
 * @optional.
 */
@property (nonatomic, readonly) BOOL isOptional;

/**
 * Answers the number of arguments of the receiver's mirrored method description, 
 * not including the implicit self and _cmd arguments.
 */
- (NSUInteger)numberOfArguments;

/**
 * Answers the selector of the receiver's mirrored method description.
 */
- (SEL)selector;

@end
