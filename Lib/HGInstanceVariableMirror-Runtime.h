#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HGInstanceVariableMirror.h"


@interface HGInstanceVariableMirror (HGRuntimeDependent)

/**
 * Answers an instance of HGInstanceVariableMirror reflecting instanceVariable. 
 * Don't call this directly, use [reflect(...) instanceVariables] to retrieve 
 * instances of this class.
 */
- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable;

@end
