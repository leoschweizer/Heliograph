#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "OCClassMirror.h"


@interface OCMethodMirror : NSObject

@property (nonatomic, readonly) Method mirroredMethod;
@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) SEL selector;

- (instancetype)initWithDefiningClass:(OCClassMirror *)classMirror method:(Method)method;

@end
