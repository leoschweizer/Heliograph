#import <Foundation/Foundation.h>
#import "HGValueMirror.h"


@interface HGValueMirrorDescriptionVisitor : NSObject <HGValueMirrorVisitor>

@property (nonatomic, readwrite) NSString *valueDescription;

@end
