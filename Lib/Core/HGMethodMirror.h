#import <Foundation/Foundation.h>


@class HGClassMirror;
@class HGTypeMirror;


@interface HGMethodMirror : NSObject

/**
 * The HGClassMirror reflecting the receiver's mirrored method's defining class.
 */
@property (nonatomic, readonly) HGClassMirror *definingClass;

/**
 * Answers an NSArray of HGTypeMirrors reflecting the types of the arguments of
 * the receiver's mirrored method.
 */
- (NSArray *)argumentTypes;

/**
 * Answers the encoding of the receiver's mirrored method.
 */
- (const char *)encoding;

/**
 * Answers the implementation of the receiver's mirrored method.
 */
- (IMP)implementation;

/**
 * Answers the number of arguments of the receiver's mirrored method, not
 * including the implicit self and _cmd arguments.
 */
- (NSUInteger)numberOfArguments;

/**
 * Answers an HGTypeMirror reflecting the return type of the receiver's mirrored
 * method.
 */
- (HGTypeMirror *)returnType;

/**
 * Answers the selector of the receiver's mirrored method.
 */
- (SEL)selector;

@end
