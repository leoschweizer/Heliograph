#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;

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

@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) objc_property_t mirroredProperty;
@property (nonatomic, readonly) OCPropertyAttributes attributes;

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass property:(objc_property_t)aProperty;

- (BOOL)isCopied;
- (BOOL)isDynamic;
- (BOOL)isNonatomic;
- (BOOL)isReadonly;
- (BOOL)isRetained;
- (BOOL)isWeak;
- (BOOL)isGarbageCollected;

- (NSString *)name;

@end
