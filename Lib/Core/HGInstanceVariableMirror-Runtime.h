#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HGInstanceVariableMirror.h"


@interface HGInstanceVariableMirror (HGRuntimeDependent)

/**
 * The mirrored instance variable.
 */
@property (nonatomic, readonly) Ivar mirroredInstanceVariable;

/**
 * Answers an instance of HGInstanceVariableMirror reflecting instanceVariable. 
 * Don't call this directly, use [reflect(...) instanceVariables] to retrieve 
 * instances of this class.
 */
- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable;

@end
