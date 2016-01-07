#import "HGMethodWrapper.h"
#import <objc/runtime.h>
#import "HGReflect.h"
#import "HGClassMirror.h"
#import "HGMethodMirror.h"
#import "HGMethodMirror-Runtime.h"


@interface HGMethodWrapper ()

@property (nonatomic, readonly) Class wrappedClass;
@property (nonatomic, readonly) SEL wrappedSelector;

- (void)valueWithReceiver:(id)anObject invocation:(NSInvocation *)invocation;

@end


void genericForwardInvocation(id self, SEL cmd, NSInvocation *invocation) {
	SEL selector = [invocation selector];
	HGMethodWrapper *wrapperInstance = objc_getAssociatedObject(object_getClass(self), selector);
	[wrapperInstance valueWithReceiver:self invocation:invocation];
}


@implementation HGMethodWrapper

- (instancetype)initWithWrappedClass:(Class)aClass wrappedSelector:(SEL)aSelector {
	if (self = [super init]) {
		_wrappedClass = aClass;
		_wrappedSelector = aSelector;
	}
	return self;
}

- (void)install {
	
	objc_setAssociatedObject(self.wrappedClass, self.wrappedSelector, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	IMP forwardingProxy = class_getMethodImplementation([NSObject class], NSSelectorFromString(@"hg__this__does__not__exist"));
	IMP originalImp = class_getMethodImplementation(self.wrappedClass, self.wrappedSelector);
	
	HGClassMirror *classMirror = reflect(self.wrappedClass);
	HGMethodMirror *wrappedMethodMirror = [classMirror methodWithSelector:self.wrappedSelector];
	HGMethodMirror *forwardInvocationMirror = [classMirror methodWithSelector:@selector(forwardInvocation:)];
	const char *wrappedMethodEncoding = method_getTypeEncoding([wrappedMethodMirror mirroredMethod]);
	const char *forwardInvocationEncoding = method_getTypeEncoding([forwardInvocationMirror mirroredMethod]);
	
	SEL s1 = NSSelectorFromString([NSString stringWithFormat:@"hg_mw_swizzled_%@", NSStringFromSelector(self.wrappedSelector)]);
	
	class_addMethod(self.wrappedClass, s1, originalImp, wrappedMethodEncoding);
	if ([[wrappedMethodMirror definingClass] mirroredClass] != self.wrappedClass) {
		class_addMethod(self.wrappedClass, self.wrappedSelector, forwardingProxy, wrappedMethodEncoding);
	} else {
		method_setImplementation([wrappedMethodMirror mirroredMethod], forwardingProxy);
	}
	
	if ([[forwardInvocationMirror definingClass] mirroredClass] != self.wrappedClass) {
		class_addMethod(self.wrappedClass, @selector(forwardInvocation:), (IMP)genericForwardInvocation, forwardInvocationEncoding);
	} else {
		method_setImplementation([forwardInvocationMirror mirroredMethod], (IMP)genericForwardInvocation);
	}
	
	
}

- (void)uninstall {
	objc_setAssociatedObject(self.wrappedClass, self.wrappedSelector, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)valueWithReceiver:(id)anObject invocation:(NSInvocation *)invocation {
	[self beforeMethod];
	
	SEL s1 = NSSelectorFromString([NSString stringWithFormat:@"hg_mw_swizzled_%@", NSStringFromSelector(self.wrappedSelector)]);
	invocation.selector = s1;
	[invocation invoke];
	
	[self afterMethod];
}

- (void)beforeMethod {
	;
}

- (void)afterMethod {
	;
}

@end
