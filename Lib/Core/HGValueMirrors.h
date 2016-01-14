#import <Foundation/Foundation.h>
#import "HGValueMirror.h"


@class HGClassMirror;


@interface HGBaseValueMirror : NSObject <HGValueMirror>

/**
 * The mirrored value.
 */
@property (nonatomic, readonly) NSValue *mirroredValue;

/**
 * Answers an HGValueMirror reflecting aValue.
 */
- (instancetype)initWithValue:(NSValue *)aValue;

@end


@interface HGObjectMirror : HGBaseValueMirror

/**
 * The mirrored object.
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
 * Alias for classMirror.
 */
- (HGClassMirror *)type;

/**
 * Answers an NSArray of HGMethodMirrors reflecting the instance methods of the
 * receiver's mirrored object's class.
 */
- (NSArray *)instanceMethods;

@end


@interface HGCharValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's char value.
 */
- (char)charValue;

@end


@interface HGShortValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's short value.
 */
- (short)shortValue;

@end


@interface HGIntValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's int value.
 */
- (int)intValue;

@end


@interface HGLongValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's long value.
 */
- (long)longValue;

@end


@interface HGLongLongValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's long value. This exists for convenience reasons since
 * long is encoded as long long on certain architectures.
 */
- (long long)longValue;

/**
 * Answers the receiver's long long value.
 */
- (long long)longLongValue;

@end


@interface HGUnsignedCharValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's unsigned char value.
 */
- (unsigned char)unsignedCharValue;

@end


@interface HGUnsignedShortValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's unsigned short value.
 */
- (unsigned short)unsignedShortValue;

@end


@interface HGUnsignedIntValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's unsigned int value.
 */
- (unsigned int)unsignedIntValue;

@end


@interface HGUnsignedLongValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's unsigned long value.
 */
- (unsigned long)unsignedLongValue;

@end


@interface HGUnsignedLongLongValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's unsigned long value. This exists for convenience 
 * reasons since unsigned long is encoded as unsigned long long on certain 
 * architectures.
 */
- (unsigned long long)unsignedLongValue;

/**
 * Answers the receiver's unsigned long value.
 */
- (unsigned long long)unsignedLongLongValue;

@end


@interface HGFloatValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's float value.
 */
- (float)floatValue;

@end


@interface HGDoubleValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's double value.
 */
- (double)doubleValue;

@end


@interface HGBoolValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's _Bool value.
 */
- (_Bool)boolValue;

@end


@interface HGCharacterStringValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's char * value.
 */
- (char *)characterStringValue;

@end


@interface HGSelectorValueMirror : HGBaseValueMirror

/**
 * Answers the receiver's SEL value.
 */
- (SEL)selectorValue;

@end


@interface HGArrayValueMirror : HGBaseValueMirror

/**
 * Writes the receiver's mirrored array into outArray.
 */
- (void)readArrayValue:(void *)outArray;

@end


@interface HGStructureValueMirror : HGBaseValueMirror

/**
 * Writes the receiver's mirrored struct into outStructure.
 */
- (void)readStructureValue:(void *)outStructure;

@end


@interface HGUnionValueMirror : HGBaseValueMirror

/**
 * Writes the receiver's mirrored union into outUnion.
 */
- (void)readUnionValue:(void *)outUnion;

@end


@interface HGBitFieldValueMirror : HGBaseValueMirror

@end


@interface HGVoidValueMirror : HGBaseValueMirror

@end


@interface HGPointerValueMirror : HGBaseValueMirror

@end


@interface HGUnknownValueMirror : HGBaseValueMirror

@end
