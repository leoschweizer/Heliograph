#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;


@interface OCPropertyMirror : NSObject

@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) objc_property_t mirroredProperty;

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass property:(objc_property_t)aProperty;

- (BOOL)isReadonly;

- (NSString *)name;

@end
