#import "HGMethodWrapper.h"
#import <objc/runtime.h>
#import "HGReflect.h"
#import "HGClassMirror.h"
#import "HGMethodMirror.h"
#import "HGMethodMirror-Runtime.h"


@interface HGMethodWrapper ()

@property (nonatomic, readonly) Class wrappedClass;
@property (nonatomic, readonly) SEL wrappedSelector;

- (void)valueWithReceiver:(id)anObject returnValue:(void *)returnValue arguments:(va_list)arguments;

@end


id genericImp(id self, SEL _cmd, ...) {
	HGMethodWrapper *wrapperInstance = objc_getAssociatedObject(object_getClass(self), _cmd);
	va_list arguments;
	va_start(arguments, _cmd);
	NSLogv(@"%i", arguments);
	[wrapperInstance valueWithReceiver:self returnValue:NULL arguments:arguments];
	va_end(arguments);
	return nil;
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
	
	HGClassMirror *classMirror = reflect(self.wrappedClass);
	HGMethodMirror *methodMirror = [classMirror methodWithSelector:self.wrappedSelector];
	SEL injectedSelector = NSSelectorFromString([NSString stringWithFormat:@"hg__wrapped__%@", NSStringFromSelector(self.wrappedSelector)]);
	const char * encoding = method_getTypeEncoding(methodMirror.mirroredMethod);
	
	BOOL didAdd = class_addMethod(self.wrappedClass, injectedSelector, (IMP)genericImp, encoding);
	Method genericMethod = [[classMirror methodWithSelector:injectedSelector] mirroredMethod];
	
	method_exchangeImplementations(methodMirror.mirroredMethod, genericMethod);
	
}

- (void)uninstall {
	objc_setAssociatedObject(self.wrappedClass, self.wrappedSelector, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)valueWithReceiver:(id)anObject returnValue:(void *)returnValue arguments:(va_list)arguments {
	[self beforeMethod];
	
	SEL injectedSelector = NSSelectorFromString([NSString stringWithFormat:@"hg__wrapped__%@", NSStringFromSelector(self.wrappedSelector)]);
	NSMethodSignature *signature = [anObject methodSignatureForSelector:injectedSelector];
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	NSUInteger argumentCount = [signature numberOfArguments];
	
	[invocation setTarget:anObject];
	[invocation setSelector:injectedSelector];
	for(NSUInteger i = 2; i < argumentCount; i++) {
		const char *type = [signature getArgumentTypeAtIndex:i];
		NSUInteger arg_size;
		NSGetSizeAndAlignment(type, &arg_size, NULL);
		void * arg_buffer = malloc(arg_size);
		arg_buffer = va_arg(arguments, void *);
		[invocation setArgument:arg_buffer atIndex:i];
		free(arg_buffer);
		//if (strcmp(@encode(int), type) == 0) {
			// the argument is an int
		//	int anInt = va_arg(arguments, int);
		//	[invocation setArgument:&anInt atIndex:i];
		//}
		//void *argPtr = va_arg(arguments, void *);
		//[invocation setArgument: argPtr atIndex: i];
	}
	
	[invocation invoke];
	
	if([signature methodReturnLength] && returnValue)
		[invocation getReturnValue: returnValue];
	
	[self afterMethod];
}

- (void)beforeMethod {
	;
}

- (void)afterMethod {
	;
}

-does

@end
