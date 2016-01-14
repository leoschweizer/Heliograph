#import <Foundation/Foundation.h>


@class HGClassMirror;
@protocol HGTypeMirror;
@protocol HGValueMirror;


@interface HGMethodMirror : NSObject <NSCopying>

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
 * Invokes the receiver's mirrored method on aTarget.
 * @return an NSValue wrapping the result of the invocation.
 * @note primitive arguments must be wrapped as NSValue instances, arguments
 *  of type id can be passed as-is.
 */
- (id<HGValueMirror>)invokeOn:(id)aTarget withArguments:(NSArray *)arguments;

/**
 * Invokes the receiver's mirrored method on aTarget and writes the result of
 * the invocation to outPointer.
 * @note primitive arguments must be wrapped as NSValue instances, arguments
 *  of type id can be passed as-is.
 */
- (void)invokeOn:(id)aTarget withArguments:(NSArray *)arguments returnValue:(void *)outPointer;

/**
 * Answers the number of arguments of the receiver's mirrored method, not
 * including the implicit self and _cmd arguments.
 */
- (NSUInteger)numberOfArguments;

/**
 * Replaces the implementation of the receiver's mirrored method with 
 * anImplementation.
 * @return the old implementation of the receiver's mirrored method.
 */
- (IMP)replaceImplementationWith:(IMP)anImplementation;

/**
 * Answers an HGTypeMirror reflecting the return type of the receiver's mirrored
 * method.
 */
- (id<HGTypeMirror>)returnType;

/**
 * Answers the selector of the receiver's mirrored method.
 */
- (SEL)selector;

/**
 * Compares the receiving HGMethodMirror to another HGMethodMirror.
 */
- (BOOL)isEqualToMethodMirror:(HGMethodMirror *)aMethodMirror;

@end
