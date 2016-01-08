#import "HGClassMirror.h"
#import <objc/runtime.h>
#import "HGMethodMirror-Runtime.h"
#import "HGPropertyMirror-Runtime.h"
#import "HGInstanceVariableMirror-Runtime.h"
#import "HGProtocolMirror.h"


@interface HGClassMirror ()

@property (nonatomic, readonly) NSValue *mirroredClassStorage;

@end


@implementation HGClassMirror

+ (NSArray *)allClasses {
	unsigned int numberOfClasses = objc_getClassList(NULL, 0);
	Class *classes = objc_copyClassList(&numberOfClasses);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:numberOfClasses];
	for (int i = 0; i < numberOfClasses; i++) {
		Class class = classes[i];
		HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:class];
		[result addObject:mirror];
	}
	free(classes);
	return [NSArray arrayWithArray:result];
}

- (instancetype)initWithClass:(Class)aClass {
	if (self = [super init]) {
		_mirroredClassStorage = [NSValue valueWithNonretainedObject:aClass];
	}
	return self;
}

- (HGClassMirror *)addSubclassNamed:(NSString *)aClassName {
	Class class = objc_allocateClassPair(self.mirroredClass, [aClassName UTF8String], 0);
	if (!class) {
		return 0;
	}
	objc_registerClassPair(class);
	return [[[self class] alloc] initWithClass:class];
}

- (NSArray *)adoptedProtocols {
	unsigned int protocolCount = 0;
	Protocol * __unsafe_unretained *protocols = class_copyProtocolList(self.mirroredClass, &protocolCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:protocolCount];
	for (int i = 0; i < protocolCount; i++) {
		Protocol *protocol = protocols[i];
		HGProtocolMirror *mirror = [[HGProtocolMirror alloc] initWithProtocol:protocol];
		[result addObject:mirror];
	}
	free(protocols);
	return result;
}

- (NSArray *)allSubclasses {
	
	unsigned int numberOfClasses = objc_getClassList(NULL, 0);
	Class *classes = objc_copyClassList(&numberOfClasses);
	NSMutableArray *result = [NSMutableArray array];
	
	for (int i = 0; i < numberOfClasses; i++) {
		
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
	return result;
	
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

- (NSArray *)instanceVariables {
	
	unsigned int instanceVariableCount;
	Ivar *instanceVariables = class_copyIvarList(self.mirroredClass, &instanceVariableCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:instanceVariableCount];
	
	for (int i = 0; i < instanceVariableCount; i++) {
		Ivar var = instanceVariables[i];
		HGInstanceVariableMirror *mirror = [[HGInstanceVariableMirror alloc] initWithDefiningClass:self instanceVariable:var];
		[result addObject:mirror];
	}
	
	free(instanceVariables);
	return result;
	
}

- (HGInstanceVariableMirror *)instanceVariableNamed:(NSString *)aName {
	Ivar instanceVariable = class_getInstanceVariable(self.mirroredClass, [aName UTF8String]);
	return instanceVariable ? [[HGInstanceVariableMirror alloc] initWithDefiningClass:self instanceVariable:instanceVariable] : nil;
}

- (BOOL)isMetaclass {
	return class_isMetaClass(self.mirroredClass);
}

- (NSArray *)methods {
	
	unsigned int methodCount = 0;
	Method *methods = class_copyMethodList(self.mirroredClass, &methodCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:methodCount];
	
	for (unsigned int i = 0; i < methodCount; i++) {
		Method method = methods[i];
		HGMethodMirror *methodMirror = [[HGMethodMirror alloc] initWithDefiningClass:self method:method];
		[result addObject:methodMirror];
	}
	
	free(methods);
	return result;
	
}

- (HGMethodMirror *)methodWithSelector:(SEL)aSelector {
	Method method = class_getInstanceMethod(self.mirroredClass, aSelector);
	HGClassMirror *definingClass = nil;
	HGClassMirror *inspectedClass = self;
	while (method && !definingClass) {
		for (HGMethodMirror *m in [inspectedClass methods]) {
			if ([m selector] == aSelector) {
				definingClass = inspectedClass;
				continue;
			}
		}
		inspectedClass = [inspectedClass superclass];
	}
	return method ? [[HGMethodMirror alloc] initWithDefiningClass:definingClass method:method] : nil;
}

- (Class)mirroredClass {
	return [self.mirroredClassStorage nonretainedObjectValue];
}

- (NSString *)name {
	return [NSString stringWithUTF8String:class_getName(self.mirroredClass)];
}

- (NSArray *)properties {
	unsigned int outCount = 0;
	objc_property_t *properties = class_copyPropertyList(self.mirroredClass, &outCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:outCount];
	for (int i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		HGPropertyMirror *mirror = [[HGPropertyMirror alloc] initWithDefiningClass:self property:property];
		[result addObject:mirror];
	}
	return result;
}

- (HGPropertyMirror *)propertyNamed:(NSString *)aName {
	objc_property_t property = class_getProperty(self.mirroredClass, [aName UTF8String]);
	return property ? [[HGPropertyMirror alloc] initWithDefiningClass:self property:property] : nil;
}

- (NSArray *)subclasses {
	
	unsigned int numberOfClasses = objc_getClassList(NULL, 0);
	Class *classes = objc_copyClassList(&numberOfClasses);
	NSMutableArray *result = [NSMutableArray array];
	
	for (int i = 0; i < numberOfClasses; i++) {
		Class superClass = class_getSuperclass(classes[i]);
		if (superClass == self.mirroredClass) {
			HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:classes[i]];
			[result addObject:mirror];
		}
	}
	
	free(classes);
	return result;
	
}

- (HGClassMirror *)superclass {
	Class superclass = class_getSuperclass(self.mirroredClass);
	return superclass ? [[HGClassMirror alloc] initWithClass:superclass] : nil;
}

@end
