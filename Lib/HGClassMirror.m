#import "HGClassMirror.h"
#import <objc/runtime.h>
#import "HGMethodMirror.h"
#import "HGPropertyMirror.h"
#import "HGInstanceVariableMirror.h"
#import "HGProtocolMirror.h"


@implementation HGClassMirror

- (instancetype)initWithClass:(Class)aClass {
	if (self = [super init]) {
		_mirroredClass = aClass;
		_name = NSStringFromClass(aClass);
	}
	return self;
}

- (NSArray *)adoptedProtocols {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int protocolCount = 0;
	Protocol * __unsafe_unretained *protocols = class_copyProtocolList(self.mirroredClass, &protocolCount);
	for (int i = 0; i < protocolCount; i++) {
		Protocol *protocol = protocols[i];
		HGProtocolMirror *mirror = [[HGProtocolMirror alloc] initWithProtocol:protocol];
		[result addObject:mirror];
	}
	free(protocols);
	return [NSArray arrayWithArray:result];
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
		
		HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:classes[i]];
		[result addObject:mirror];
		
	}
	
	free(classes);
	
	return [NSArray arrayWithArray:result];
	
}

- (HGClassMirror *)classMirror {
	Class class = object_getClass(self.mirroredClass);
	return class ? [[HGClassMirror alloc] initWithClass:class] : nil;
}

- (NSString *)description {
	if ([self isMetaclass]) {
		return [NSString stringWithFormat:@"<HGClassMirror on %@ class>", self.name];
	}
	return [NSString stringWithFormat:@"<HGClassMirror on %@>", self.name];
}

- (NSDictionary *)instanceVariables {
	
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	unsigned int instanceVariableCount;
	Ivar *instanceVariables = class_copyIvarList(self.mirroredClass, &instanceVariableCount);
	
	for (int i = 0; i < instanceVariableCount; i++) {
		Ivar var = instanceVariables[i];
		HGInstanceVariableMirror *mirror = [[HGInstanceVariableMirror alloc] initWithDefiningClass:self instanceVariable:var];
		[result setObject:mirror forKey:mirror.name];
	}
	
	free(instanceVariables);
	return [NSDictionary dictionaryWithDictionary:result];
	
}

- (BOOL)isMetaclass {
	return class_isMetaClass(self.mirroredClass);
}

- (NSDictionary *)methodDictionary {
	
	NSMutableDictionary *methodDict = [NSMutableDictionary dictionary];
	unsigned int methodCount = 0;
	Method *methods = class_copyMethodList(self.mirroredClass, &methodCount);
	
	for (unsigned int i = 0; i < methodCount; i++) {
		Method method = methods[i];
		HGMethodMirror *methodMirror = [[HGMethodMirror alloc] initWithDefiningClass:self method:method];
		[methodDict setObject:methodMirror forKey:NSStringFromSelector(methodMirror.selector)];
	}
	
	free(methods);
	return [NSDictionary dictionaryWithDictionary:methodDict];
	
}

- (NSDictionary *)properties {
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList(self.mirroredClass, &outCount);
	for (i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		HGPropertyMirror *mirror = [[HGPropertyMirror alloc] initWithDefiningClass:self property:property];
		[result setObject:mirror forKey:mirror.name];
	}
	return [NSDictionary dictionaryWithDictionary:result];
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
			HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:classes[i]];
			[result addObject:mirror];
		}
	}
	
	free(classes);
	return [NSArray arrayWithArray:result];
	
}

- (HGClassMirror *)superclass {
	Class superclass = class_getSuperclass(self.mirroredClass);
	return superclass ? [[HGClassMirror alloc] initWithClass:superclass] : nil;
}

@end
