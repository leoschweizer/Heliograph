#import "OCClassMirror.h"
#import <objc/runtime.h>


@implementation OCClassMirror

- (instancetype)initWithClass:(Class)aClass {
	if (self = [super init]) {
		_mirroredClass = aClass;
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

- (NSString *)description {
	return [NSString stringWithFormat:@"<OCClassMirror on %@>", self.name];
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

- (NSString *)name {
	return NSStringFromClass(self.mirroredClass);
}

@end
