#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;


@interface OCInstanceVariableMirror : NSObject

@property (nonatomic, readonly) Ivar mirroredInstanceVariable;
@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable;

@end
