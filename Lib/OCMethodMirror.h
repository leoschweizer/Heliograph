#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;


@interface OCMethodMirror : NSObject

@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) Method mirroredMethod;
@property (nonatomic, readonly) NSUInteger numberOfArguments;
@property (nonatomic, readonly) SEL selector;

- (instancetype)initWithDefiningClass:(OCClassMirror *)classMirror method:(Method)method;

@end
