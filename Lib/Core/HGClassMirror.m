#import "HGClassMirror.h"
#import <objc/runtime.h>
#import "HGMethodMirror-Runtime.h"
#import "HGPropertyMirror-Runtime.h"
#import "HGInstanceVariableMirror-Runtime.h"
#import "HGProtocolMirror.h"
#import "HGTypeMirrorDescriptionVisitor.h"
#import "HGValueMirrorDescriptionVisitor.h"


@interface HGClassMirror ()

@end


@implementation HGClassMirror

+ (NSArray *)allClasses {
	unsigned int numberOfClasses;
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
		_mirroredClassStorage = (__bridge void *)(aClass);
	}
	return self;
}

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitClassMirror:)]) {
		[aVisitor visitClassMirror:self];
	}
}

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitClassMirror:)]) {
		[aVisitor visitClassMirror:self];
	}
}

- (HGInstanceVariableMirror *)addInstanceVariableNamed:(NSString *)aName withEncoding:(const char *)anEncoding {
	NSUInteger size, alignment;
	NSGetSizeAndAlignment(anEncoding, &size, &alignment);
	BOOL didAdd = class_addIvar(self.mirroredClassStorage, [aName UTF8String], size, alignment, anEncoding);
	if (!didAdd) {
		return nil;
	}
	return [self instanceVariableNamed:aName];
}

- (HGMethodMirror *)addMethodNamed:(SEL)aSelector withImplementation:(IMP)anImplementation andEncoding:(const char *)anEncoding {
	BOOL didAdd = class_addMethod(self.mirroredClassStorage, aSelector, anImplementation, anEncoding);
	if (!didAdd) {
		return nil;
	}
	return [self methodNamed:aSelector];
}

- (HGClassMirror *)addSubclassNamed:(NSString *)aClassName {
	Class class = objc_allocateClassPair(self.mirroredClassStorage, [aClassName UTF8String], 0);
	if (!class) {
		return 0;
	}
	return [[[self class] alloc] initWithClass:class];
}

- (NSArray *)adoptedProtocols {
	unsigned int protocolCount = 0;
	Protocol * __unsafe_unretained *protocols = class_copyProtocolList(self.mirroredClassStorage, &protocolCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:protocolCount];
	for (int i = 0; i < protocolCount; i++) {
		Protocol *protocol = protocols[i];
		HGProtocolMirror *mirror = [[HGProtocolMirror alloc] initWithProtocol:protocol];
		[result addObject:mirror];
	}
	free(protocols);
	return result;
}

- (HGProtocolMirror *)adoptProtocol:(Protocol *)aProtocol {
	BOOL didAdopt = class_addProtocol(self.mirroredClassStorage, aProtocol);
	if (!didAdopt) {
		return nil;
	}
	return [[HGProtocolMirror alloc] initWithProtocol:aProtocol];
}

- (NSArray *)allSubclasses {
	
	unsigned int numberOfClasses;
	Class *classes = objc_copyClassList(&numberOfClasses);
	NSMutableArray *result = [NSMutableArray array];
	
	for (int i = 0; i < numberOfClasses; i++) {
		
		Class superClass = classes[i];
		
		do {
			superClass = class_getSuperclass(superClass);
		} while(superClass && superClass != self.mirroredClassStorage);
		
		if (!superClass) {
			continue;
		}
		
		HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:classes[i]];
		[result addObject:mirror];
		
	}
	
	free(classes);
	return result;
	
}

- (NSArray *)allSuperclasses {
	NSMutableArray *result = [NSMutableArray array];
	HGClassMirror *superclass = [self superclass];
	while (superclass) {
		[result addObject:superclass];
		superclass = [superclass superclass];
	}
	return result;
}

- (HGClassMirror *)classMirror {
	Class class = object_getClass(self.mirroredClassStorage);
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
	Ivar *instanceVariables = class_copyIvarList(self.mirroredClassStorage, &instanceVariableCount);
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
	Ivar instanceVariable = class_getInstanceVariable(self.mirroredClassStorage, [aName UTF8String]);
	return instanceVariable ? [[HGInstanceVariableMirror alloc] initWithDefiningClass:self instanceVariable:instanceVariable] : nil;
}

- (BOOL)isMetaclass {
	return class_isMetaClass(self.mirroredClassStorage);
}

- (NSArray *)methods {
	
	unsigned int methodCount = 0;
	Method *methods = class_copyMethodList(self.mirroredClassStorage, &methodCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:methodCount];
	
	for (unsigned int i = 0; i < methodCount; i++) {
		Method method = methods[i];
		HGMethodMirror *methodMirror = [[HGMethodMirror alloc] initWithDefiningClass:self method:method];
		[result addObject:methodMirror];
	}
	
	free(methods);
	return result;
	
}

- (HGMethodMirror *)methodNamed:(SEL)aSelector {
	Method method = class_getInstanceMethod(self.mirroredClassStorage, aSelector);
	HGClassMirror *definingClass = nil;
	HGClassMirror *inspectedClass = self;
	while (method && !definingClass && inspectedClass) {
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
	return self.mirroredClassStorage;
}

- (NSValue *)mirroredValue {
	return [NSValue valueWithBytes:&_mirroredClassStorage objCType:@encode(Class)];
}

- (NSString *)name {
	return [NSString stringWithUTF8String:class_getName(self.mirroredClassStorage)];
}

- (NSArray *)properties {
	unsigned int outCount = 0;
	objc_property_t *properties = class_copyPropertyList(self.mirroredClassStorage, &outCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:outCount];
	for (int i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		HGPropertyMirror *mirror = [[HGPropertyMirror alloc] initWithDefiningClass:self property:property];
		[result addObject:mirror];
	}
	return result;
}

- (HGPropertyMirror *)propertyNamed:(NSString *)aName {
	objc_property_t property = class_getProperty(self.mirroredClassStorage, [aName UTF8String]);
	return property ? [[HGPropertyMirror alloc] initWithDefiningClass:self property:property] : nil;
}

- (void)registerClass {
	objc_registerClassPair(self.mirroredClassStorage);
}

- (NSArray *)siblings {
	HGClassMirror *superclass = [self superclass];
	if (!superclass) {
		return @[];
	}
	NSMutableArray *siblings = [[superclass subclasses] mutableCopy];
	[siblings removeObject:self];
	return siblings;
}

- (NSArray *)subclasses {
	
	unsigned int numberOfClasses;
	Class *classes = objc_copyClassList(&numberOfClasses);
	NSMutableArray *result = [NSMutableArray array];
	
	for (int i = 0; i < numberOfClasses; i++) {
		Class superClass = class_getSuperclass(classes[i]);
		if (superClass == self.mirroredClassStorage) {
			HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:classes[i]];
			[result addObject:mirror];
		}
	}
	
	free(classes);
	return result;
	
}

- (HGClassMirror *)superclass {
	Class superclass = class_getSuperclass(self.mirroredClassStorage);
	return superclass ? [[HGClassMirror alloc] initWithClass:superclass] : nil;
}

- (NSString *)typeDescription {
	HGTypeMirrorDescriptionVisitor *visitor = [[HGTypeMirrorDescriptionVisitor alloc] init];
	[self acceptTypeMirrorVisitor:visitor];
	return visitor.typeDescription;
}

- (NSString *)valueDescription {
	HGValueMirrorDescriptionVisitor *visitor = [[HGValueMirrorDescriptionVisitor alloc] init];
	[self acceptValueMirrorVisitor:visitor];
	return visitor.valueDescription;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToClassMirror:anObject];
}

- (BOOL)isEqualToClassMirror:(HGClassMirror *)aClassMirror {
	Class c1 = self.mirroredClassStorage;
	Class c2 = HGClassFromClassMirror(aClassMirror);
	return c1 == c2;
}

- (BOOL)isEqualToTypeMirror:(id<HGTypeMirror>)aTypeMirror {
	return [self isEqual:aTypeMirror];
}

- (BOOL)isEqualToValueMirror:(id<HGValueMirror>)aValueMirror {
	return [self isEqual:aValueMirror];
}

- (NSUInteger)hash {
	return [@"HGClassMirror" hash] ^ [self.name hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGClassMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_mirroredClassStorage = _mirroredClassStorage;
	return newMirror;
}

@end
