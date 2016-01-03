#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@class HGClassMirror;
@class HGTypeMirror;


@interface HGInstanceVariableMirror : NSObject

@property (nonatomic, readonly) Ivar mirroredInstanceVariable;
@property (nonatomic, readonly) HGClassMirror *definingClass;
@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable;

/**
 * Answers an HGTypeMirror reflecting the receiver's mirrored instance 
 * variable's type.
 */
- (HGTypeMirror *)type;

@end
