#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@class HGInstanceVariableMirror;


@interface HGInstanceVariableInjectionVisitor : NSObject <HGTypeMirrorVisitor>

- (instancetype)initWithInstanceVariable:(HGInstanceVariableMirror *)instanceVariable target:(id)anObject value:(id)aValue;

@end
