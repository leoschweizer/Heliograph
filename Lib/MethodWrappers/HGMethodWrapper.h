#import <Foundation/Foundation.h>


@interface HGMethodWrapper : NSObject

- (instancetype)initWithWrappedClass:(Class)aClass wrappedSelector:(SEL)aSelector;

- (void)install;
- (void)uninstall;

- (void)invocation:(NSInvocation *)invocation withTarget:(id)anObject;
- (void)beforeMethod;
- (void)afterMethod;

@end
