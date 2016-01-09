#import <Foundation/Foundation.h>
#import "HGValueMirror.h"


@class HGClassMirror;


@interface HGBaseValueMirror : NSObject <HGValueMirror>

@property (nonatomic, readonly) void *value;

- (instancetype)initWithValue:(void *)aValue;

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


@interface HGCharValueMirror : HGBaseValueMirror

@end


@interface HGShortValueMirror : HGBaseValueMirror

@end


@interface HGIntValueMirror : HGBaseValueMirror

@end


@interface HGLongValueMirror : HGBaseValueMirror

@end


@interface HGLongLongValueMirror : HGBaseValueMirror

@end


@interface HGUnsignedCharValueMirror : HGBaseValueMirror

@end


@interface HGUnsignedShortValueMirror : HGBaseValueMirror

@end


@interface HGUnsignedIntValueMirror : HGBaseValueMirror

@end


@interface HGUnsignedLongValueMirror : HGBaseValueMirror

@end


@interface HGUnsignedLongLongValueMirror : HGBaseValueMirror

@end


@interface HGFloatValueMirror : HGBaseValueMirror

@end


@interface HGDoubleValueMirror : HGBaseValueMirror

@end


@interface HGBoolValueMirror : HGBaseValueMirror

@end


@interface HGCharacterStringValueMirror : HGBaseValueMirror

@end


@interface HGSelectorValueMirror : HGBaseValueMirror

@end


@interface HGVoidValueMirror : HGBaseValueMirror

@end


@interface HGArrayValueMirror : HGBaseValueMirror

@end


@interface HGStructureValueMirror : HGBaseValueMirror

@end


@interface HGUnionValueMirror : HGBaseValueMirror

@end


@interface HGBitFieldValueMirror : HGBaseValueMirror

@end


@interface HGPointerValueMirror : HGBaseValueMirror

@end


@interface HGUnknownValueMirror : HGBaseValueMirror

@end
