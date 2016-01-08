#import "HGMethodDescriptionMirror.h"
#import <objc/runtime.h>


@interface HGMethodDescriptionMirror (HGRuntimeDependent)

@property (nonatomic, readonly) struct objc_method_description mirroredMethodDescription;

- (instancetype)initWithDefiningProtocol:(HGProtocolMirror *)aProtocol methodDescription:(struct objc_method_description)methodDescription isRequired:(BOOL)isRequired isInstanceMethod:(BOOL)isInstanceMethod;

@end
