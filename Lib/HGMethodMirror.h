#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class HGClassMirror;
@class HGTypeMirror;


@interface HGMethodMirror : NSObject

/**
 * The HGClassMirror reflecting the receiver's mirrored method's defining class.
 */
@property (nonatomic, readonly) HGClassMirror *definingClass;

/**
 * The reflected method.
 */
@property (nonatomic, readonly) Method mirroredMethod;

/**
 * Answers an instance of HGMethodMirror reflecting aMethod. Don't call this
 * directly, use [reflect(...) methodDictionary] to retrieve instances of
 * this class.
 */
- (instancetype)initWithDefiningClass:(HGClassMirror *)classMirror method:(Method)aMethod;

/**
 * Answers an NSArray of HGTypeMirrors reflecting the types of the arguments of
 * the receiver's mirrored method.
 */
- (NSArray *)argumentTypes;

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
