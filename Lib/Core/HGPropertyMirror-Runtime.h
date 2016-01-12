#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "HGPropertyMirror.h"


@interface HGPropertyMirror (HGRuntimeDependent)

/**
 * The mirrored property.
 */
@property (nonatomic, readonly) objc_property_t mirroredProperty;

/**
 * Answers an HGPropertyMirror reflecting aProperty. Don't call this yourself,
 * use [reflect(...) properties] instead to retrieve instances of this class.
 */
- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass property:(objc_property_t)aProperty;

/**
 * Answers an HGPropertyMirror reflecting aProperty. Don't call this yourself,
 * use [reflect(...) properties] instead to retrieve instances of this class.
 */
- (instancetype)initWithDefiningProtocol:(HGProtocolMirror *)definingProtocol property:(objc_property_t)aProperty;

@end
