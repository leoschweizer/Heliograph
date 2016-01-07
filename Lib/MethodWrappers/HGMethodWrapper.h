#import <Foundation/Foundation.h>


@interface HGMethodWrapper : NSObject

- (instancetype)initWithWrappedClass:(Class)aClass wrappedSelector:(SEL)aSelector;

- (void)install;

- (void)uninstall;

@end
