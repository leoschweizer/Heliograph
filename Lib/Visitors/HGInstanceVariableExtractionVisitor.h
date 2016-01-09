#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@class HGInstanceVariableMirror;
@protocol HGValueMirror;


@interface HGInstanceVariableExtractionVisitor : NSObject <HGTypeMirrorVisitor>

@property (nonatomic, readonly) id<HGValueMirror> value;

- (instancetype)initWithInstanceVariable:(HGInstanceVariableMirror *)instanceVariable target:(id)anObject;

@end
