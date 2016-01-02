#import <Foundation/Foundation.h>


@class OCClassMirror;


@interface OCValueMirror : NSObject

@end


@interface OCObjectMirror : OCValueMirror

/**
 * The reflected object.
 */
@property (nonatomic, readonly) id mirroredObject;

/**
 * Answers an OCObjectMirror instance reflecting anObject.
 */
- (instancetype)initWithObject:(id)anObject;

/**
 * Answers a NSDictionary mapping each of the receiver's class method selectors
 * to a corresponding OCMethodMirror instance.
 */
- (NSDictionary *)classMethods;

/**
 * Answers an OCClassMirror instance reflecting the class of the receiver's
 * mirroredObject.
 */
- (OCClassMirror *)classMirror;

/**
 * Answers a NSDictionary mapping each of the receiver's instance method
 * selectors to a corresponding OCMethodMirror instance.
 */
- (NSDictionary *)instanceMethods;

@end
