#import "HGMethodWrapper.h"
#import <objc/runtime.h>
#import "HGReflect.h"
#import "HGClassMirror.h"
#import "HGMethodMirror.h"
#import "HGMethodMirror-Runtime.h"


@interface HGMethodWrapper ()

@property (nonatomic, readonly) Class wrappedClass;
@property (nonatomic, readonly) SEL wrappedSelector;
@property (nonatomic, readonly) SEL backingSelector;

- (void)internalInvocation:(NSInvocation *)invocation withTarget:(id)anObject;

@end


SEL backingSelectorForSelector(SEL selector) {
	return NSSelectorFromString([NSString stringWithFormat:@"hg_mw_swizzled_%@", NSStringFromSelector(selector)]);
}

void HGDispatchWrappedMethod(id self, SEL cmd, NSInvocation *invocation) {
	SEL selector = backingSelectorForSelector(invocation.selector);
	HGMethodWrapper *wrapperInstance = objc_getAssociatedObject(object_getClass(self), selector);
	[wrapperInstance internalInvocation:invocation withTarget:self];
}


@implementation HGMethodWrapper

- (instancetype)initWithWrappedClass:(Class)aClass wrappedSelector:(SEL)aSelector {
	if (self = [super init]) {
		_wrappedClass = aClass;
		_wrappedSelector = aSelector;
		_backingSelector = backingSelectorForSelector(_wrappedSelector);
	}
	return self;
}

- (void)injectForwardInvocationImplementation {
	
	HGClassMirror *classMirror = reflect(self.wrappedClass);
	HGMethodMirror *forwardInvocationMirror = [classMirror methodWithSelector:@selector(forwardInvocation:)];
	IMP currentForwardInvocationImp = method_getImplementation([forwardInvocationMirror mirroredMethod]);
	
	if (currentForwardInvocationImp == (IMP)HGDispatchWrappedMethod) {
		return;
	}
	
	const char *forwardInvocationEncoding = method_getTypeEncoding([forwardInvocationMirror mirroredMethod]);
	class_addMethod(self.wrappedClass, NSSelectorFromString(@"hg_original_forwardInvocation:"), currentForwardInvocationImp, forwardInvocationEncoding);
	if ([[forwardInvocationMirror definingClass] mirroredClass] != self.wrappedClass) {
		class_addMethod(self.wrappedClass, @selector(forwardInvocation:), (IMP)HGDispatchWrappedMethod, forwardInvocationEncoding);
	} else {
		method_setImplementation([forwardInvocationMirror mirroredMethod], (IMP)HGDispatchWrappedMethod);
	}
	
}

- (void)injectAssociationToSelf {
	objc_setAssociatedObject(self.wrappedClass, self.backingSelector, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)injectForwardingProxy {
	
	IMP forwardingProxy = class_getMethodImplementation([NSObject class], NSSelectorFromString(@"hg__this__does__not__exist"));
	IMP originalImp = class_getMethodImplementation(self.wrappedClass, self.wrappedSelector);
	
	HGClassMirror *classMirror = reflect(self.wrappedClass);
	HGMethodMirror *wrappedMethodMirror = [classMirror methodWithSelector:self.wrappedSelector];
	const char *wrappedMethodEncoding = method_getTypeEncoding([wrappedMethodMirror mirroredMethod]);
	
	class_addMethod(self.wrappedClass, self.backingSelector, originalImp, wrappedMethodEncoding);
	if ([[wrappedMethodMirror definingClass] mirroredClass] != self.wrappedClass) {
		class_addMethod(self.wrappedClass, self.wrappedSelector, forwardingProxy, wrappedMethodEncoding);
	} else {
		method_setImplementation([wrappedMethodMirror mirroredMethod], forwardingProxy);
	}
	
}

- (void)install {
	[self injectForwardInvocationImplementation];
	[self injectAssociationToSelf];
	[self injectForwardingProxy];
}

- (void)uninstall {
	objc_setAssociatedObject(self.wrappedClass, self.backingSelector, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)internalInvocation:(NSInvocation *)invocation withTarget:(id)anObject {
	invocation.selector = self.backingSelector;
	[self invocation:invocation withTarget:anObject];
}

- (void)invocation:(NSInvocation *)invocation withTarget:(id)anObject {
	[self beforeMethod];
	[invocation invoke];
	[self afterMethod];
}

- (void)beforeMethod {}

- (void)afterMethod {}

@end
