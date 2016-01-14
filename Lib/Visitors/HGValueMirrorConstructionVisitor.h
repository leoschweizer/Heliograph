#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@protocol HGValueMirror;


@interface HGValueMirrorConstructionVisitor : NSObject <HGTypeMirrorVisitor>

@property (nonatomic, readonly) id value;
@property (nonatomic, readwrite) id<HGValueMirror> result;

- (instancetype)initWithValue:(id)aValue;

@end
