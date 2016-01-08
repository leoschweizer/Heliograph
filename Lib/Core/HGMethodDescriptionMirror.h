#import <Foundation/Foundation.h>


@class HGProtocolMirror;


@interface HGMethodDescriptionMirror : NSObject

/**
 * The HGProtocolMirror reflecting the receiver's mirrored method description's
 * defining protocol.
 */
@property (nonatomic, readonly) HGProtocolMirror *definingProtocol;

@property (nonatomic, readonly) BOOL isClassMethod;

@property (nonatomic, readonly) BOOL isInstanceMethod;

/**
 * Answers YES if the receiver's mirrored method description is defined as
 * @required.
 */
@property (nonatomic, readonly) BOOL isRequired;

@property (nonatomic, readonly) BOOL isOptional;

@end
