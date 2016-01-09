#import <Foundation/Foundation.h>
#import "HGValueMirror.h"


@class HGClassMirror;


@interface HGBaseValueMirror : NSObject <HGValueMirror>

@end


@interface HGObjectMirror : HGBaseValueMirror

/**
 * The reflected object.
 */
@property (nonatomic, readonly) id mirroredObject;

/**
 * Answers an HGObjectMirror instance reflecting anObject.
 */
- (instancetype)initWithObject:(id)anObject;

/**
 * Answers an NSArray of HGMethodMirrors reflecting the class methods of the
 * receiver's mirrored object's class.
 */
- (NSArray *)classMethods;

/**
 * Answers an HGClassMirror instance reflecting the class of the receiver's
 * mirroredObject.
 */
- (HGClassMirror *)classMirror;

/**
 * Answers an NSArray of HGMethodMirrors reflecting the instance methods of the
 * receiver's mirrored object's class.
 */
- (NSArray *)instanceMethods;

@end
