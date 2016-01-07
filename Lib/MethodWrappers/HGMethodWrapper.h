#import <Foundation/Foundation.h>


@interface HGMethodWrapper : NSObject

- (instancetype)initWithWrappedClass:(Class)aClass wrappedSelector:(SEL)aSelector;

- (void)install;
- (void)uninstall;

- (void)valueWithReceiver:(id)anObject invocation:(NSInvocation *)invocation;
- (void)beforeMethod;
- (void)afterMethod;

@end
