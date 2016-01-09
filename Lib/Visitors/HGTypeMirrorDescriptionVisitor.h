#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@interface HGTypeMirrorDescriptionVisitor : NSObject <HGTypeMirrorVisitor>

@property (nonatomic, readwrite) NSString *typeDescription;

@end
