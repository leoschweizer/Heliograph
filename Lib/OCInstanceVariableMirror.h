#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class OCClassMirror;
@class OCTypeMirror;


@interface OCInstanceVariableMirror : NSObject

@property (nonatomic, readonly) Ivar mirroredInstanceVariable;
@property (nonatomic, readonly) OCClassMirror *definingClass;
@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable;

/**
 * Answers an OCTypeMirror reflecting the receiver's mirrored instance 
 * variable's type.
 */
- (OCTypeMirror *)type;

@end
