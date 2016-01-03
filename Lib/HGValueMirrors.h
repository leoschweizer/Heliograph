#import <Foundation/Foundation.h>


@class HGClassMirror;


@interface HGValueMirror : NSObject

@end


@interface HGObjectMirror : HGValueMirror

/**
 * The reflected object.
 */
@property (nonatomic, readonly) id mirroredObject;

/**
 * Answers an HGObjectMirror instance reflecting anObject.
 */
- (instancetype)initWithObject:(id)anObject;

/**
 * Answers a NSDictionary mapping each of the receiver's class method selectors
 * to a corresponding HGMethodMirror instance.
 */
- (NSDictionary *)classMethods;

/**
 * Answers an HGClassMirror instance reflecting the class of the receiver's
 * mirroredObject.
 */
- (HGClassMirror *)classMirror;

/**
 * Answers a NSDictionary mapping each of the receiver's instance method
 * selectors to a corresponding HGMethodMirror instance.
 */
- (NSDictionary *)instanceMethods;

@end
