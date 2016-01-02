#import "OCClassMirror.h"
#import <objc/runtime.h>
#import "OCMethodMirror.h"


@implementation OCClassMirror

- (instancetype)initWithClass:(Class)aClass {
	if (self = [super init]) {
		_mirroredClass = aClass;
		_name = NSStringFromClass(aClass);
	}
	return self;
}

- (NSArray *)allSubclasses {
	
	int numClasses = objc_getClassList(NULL, 0);
	Class *classes = NULL;
	
	classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
	numClasses = objc_getClassList(classes, numClasses);
	
	NSMutableArray *result = [NSMutableArray array];
	for (NSInteger i = 0; i < numClasses; i++) {
		
		Class superClass = classes[i];
		
		do {
			superClass = class_getSuperclass(superClass);
		} while(superClass && superClass != self.mirroredClass);
		
		if (!superClass) {
			continue;
		}
		
		OCClassMirror *mirror = [[OCClassMirror alloc] initWithClass:classes[i]];
		[result addObject:mirror];
		
	}
	
	free(classes);
	
	return [NSArray arrayWithArray:result];
	
}

- (OCClassMirror *)classMirror {
	Class class = object_getClass(self.mirroredClass);
	return class ? [[OCClassMirror alloc] initWithClass:class] : nil;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<OCClassMirror on %@>", self.name];
}

- (NSDictionary *)methodDictionary {
	NSMutableDictionary *methodDict = [NSMutableDictionary dictionary];
	unsigned int methodCount = 0;
	Method *methods = class_copyMethodList(self.mirroredClass, &methodCount);
	
	for (unsigned int i = 0; i < methodCount; i++) {
		Method method = methods[i];
		OCMethodMirror *methodMirror = [[OCMethodMirror alloc] initWithDefiningClass:self method:method];
		[methodDict setObject:methodMirror forKey:NSStringFromSelector(methodMirror.selector)];
	}
	
	free(methods);
	return [NSDictionary dictionaryWithDictionary:methodDict];
	
}

- (NSArray *)subclasses {
	
	int numClasses = objc_getClassList(NULL, 0);
	Class *classes = NULL;
	
	classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
	numClasses = objc_getClassList(classes, numClasses);
	
	NSMutableArray *result = [NSMutableArray array];
	for (NSInteger i = 0; i < numClasses; i++) {
		Class superClass = class_getSuperclass(classes[i]);
		if (superClass == self.mirroredClass) {
			OCClassMirror *mirror = [[OCClassMirror alloc] initWithClass:classes[i]];
			[result addObject:mirror];
		}
	}
	
	free(classes);
	
	return [NSArray arrayWithArray:result];
	
}

- (OCClassMirror *)superclass {
	Class superclass = class_getSuperclass(self.mirroredClass);
	return superclass ? [[OCClassMirror alloc] initWithClass:superclass] : nil;
}

@end
