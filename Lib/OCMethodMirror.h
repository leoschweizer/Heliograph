#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;
@class OCTypeMirror;


@interface OCMethodMirror : NSObject

/**
 * The OCClassMirror reflecting the receiver's mirrored method's defining class.
 */
@property (nonatomic, readonly) OCClassMirror *definingClass;

/**
 * The reflected method.
 */
@property (nonatomic, readonly) Method mirroredMethod;

/**
 * Answers an instance of OCMethodMirror reflecting aMethod. Don't call this
 * directly, use [reflect(...) methodDictionary] to retrieve instances of
 * this class.
 */
- (instancetype)initWithDefiningClass:(OCClassMirror *)classMirror method:(Method)aMethod;

/**
 * Answers the number of arguments of the receiver's mirrored method, not
 * including the implicit self and _cmd arguments.
 */
- (NSUInteger)numberOfArguments;

/**
 * Answers an OCTypeMirror reflecting the return type of the receiver's mirrored
 * method.
 */
- (OCTypeMirror *)returnType;

/**
 * Answers the selector of the receiver's mirrored method.
 */
- (SEL)selector;

@end
