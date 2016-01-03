#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;
@class OCTypeMirror;
@class OCInstanceVariableMirror;


typedef NS_OPTIONS(NSUInteger, OCPropertyAttributes) {
	OCPropertyAttributesNone                = 0,
	OCPropertyAttributesReadonly            = 1 << 0,
	OCPropertyAttributesCopy                = 1 << 1,
	OCPropertyAttributesRetain              = 1 << 2,
	OCPropertyAttributesNonatomic           = 1 << 3,
	OCPropertyAttributesDynamic             = 1 << 4,
	OCPropertyAttributesWeak                = 1 << 5,
	OCPropertyAttributesGarbageCollection   = 1 << 6
};


@interface OCPropertyMirror : NSObject

/**
 * The OCClassMirror reflecting the receiver's mirrored propertie's defining class.
 */
@property (nonatomic, readonly) OCClassMirror *definingClass;

/**
 * The reflected property.
 */
@property (nonatomic, readonly) objc_property_t mirroredProperty;

/**
 * The attributes of the receiver's mirrored property (see OCPropertyAttributes).
 */
@property (nonatomic, readonly) OCPropertyAttributes attributes;

/**
 * The OCTypeMirror reflecting the receiver's mirrored propertie's type.
 */
@property (nonatomic, readonly) OCTypeMirror *type;

/**
 * The name of the receiver's mirrored property.
 */
@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) NSString *getterName;
@property (nonatomic, readonly) NSString *setterName;

/**
 * Answers an OCPropertyMirror reflecting aProperty. Don't call this yourself,
 * use reflect(...).properties instead to retrieve instances of this class.
 */
- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass property:(objc_property_t)aProperty;

/**
 * Answers an OCInstanceVariableMirror reflecting the instance variable backing
 * the receiver's mirrored property.
 */
- (OCInstanceVariableMirror *)backingInstanceVariable;

/**
 * Answers YES when the receiver's mirrored property is a copy of the value 
 * last assigned (copy).
 */
- (BOOL)isCopied;

/**
 * Answers YES when the receiver's mirrored proeprty is is dynamic (@dynamic).
 */
- (BOOL)isDynamic;

/**
 * Answers YES when the receiver's mirrored property is non-atomic (nonatomic).
 */
- (BOOL)isNonatomic;

/**
 * Answers YES when the receiver's mirrored property is read-only (readonly).
 */
- (BOOL)isReadonly;

/**
 * Answers YES when the receiver's mirrored property is a reference to the
 * value last assigned (retain).
 */
- (BOOL)isRetained;

/**
 * Answers YES when the receiver's mirrored property is a weak reference (__weak).
 */
- (BOOL)isWeak;

/**
 * Answers YES when the receiver's mirrored property is eligible for 
 * garbage collection.
 */
- (BOOL)isGarbageCollected;

@end