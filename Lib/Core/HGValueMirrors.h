#import <Foundation/Foundation.h>
#import "HGValueMirror.h"


@class HGClassMirror;


@interface HGBaseValueMirror : NSObject <HGValueMirror>

@property (nonatomic, readonly) NSValue *mirroredValue;

- (instancetype)initWithValue:(NSValue *)aValue;

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

- (char)charValue;

@end


@interface HGShortValueMirror : HGBaseValueMirror

- (short)shortValue;

@end


@interface HGIntValueMirror : HGBaseValueMirror

- (int)intValue;

@end


@interface HGLongValueMirror : HGBaseValueMirror

- (long)longValue;

@end


@interface HGLongLongValueMirror : HGBaseValueMirror

- (long long)longValue;
- (long long)longLongValue;

@end


@interface HGUnsignedCharValueMirror : HGBaseValueMirror

- (unsigned char)unsignedCharValue;

@end


@interface HGUnsignedShortValueMirror : HGBaseValueMirror

- (unsigned short)unsignedShortValue;

@end


@interface HGUnsignedIntValueMirror : HGBaseValueMirror

- (unsigned int)unsignedIntValue;

@end


@interface HGUnsignedLongValueMirror : HGBaseValueMirror

- (unsigned long)unsignedLongValue;

@end


@interface HGUnsignedLongLongValueMirror : HGBaseValueMirror

- (unsigned long long)unsignedLongValue;
- (unsigned long long)unsignedLongLongValue;

@end


@interface HGFloatValueMirror : HGBaseValueMirror

- (float)floatValue;

@end


@interface HGDoubleValueMirror : HGBaseValueMirror

- (double)doubleValue;

@end


@interface HGBoolValueMirror : HGBaseValueMirror

- (_Bool)boolValue;

@end


@interface HGCharacterStringValueMirror : HGBaseValueMirror

- (char *)characterStringValue;

@end


@interface HGSelectorValueMirror : HGBaseValueMirror

- (SEL)selectorValue;

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
