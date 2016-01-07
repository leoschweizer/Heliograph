#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HGMethodMirror.h"


@interface HGMethodMirror (HGRuntimeDependent)

/**
 * The wrapped method.
 */
@property (nonatomic, readonly) Method mirroredMethod;

/**
 * Answers an instance of HGMethodMirror reflecting aMethod. Don't call this
 * directly, use [reflect(...) methodDictionary] to retrieve instances of
 * this class.
 */
- (instancetype)initWithDefiningClass:(HGClassMirror *)classMirror method:(Method)aMethod;

@end
