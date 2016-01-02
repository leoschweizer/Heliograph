#import <Foundation/Foundation.h>


@interface OCClassMirror : NSObject

@property (nonatomic, readonly) Class mirroredClass;

- (instancetype)initWithClass:(Class)aClass;

@end
