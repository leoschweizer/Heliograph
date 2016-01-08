#import "HGMethodMirror.h"
#import "HGMethodMirror-Runtime.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"
#import "HGTypeMirrors.h"


@interface HGMethodMirror ()

@property (nonatomic, readonly) NSValue *mirroredMethodStorage;

@end


@implementation HGMethodMirror

- (instancetype)initWithDefiningClass:(HGClassMirror *)classMirror method:(Method)aMethod {
	if (self = [super init]) {
		_definingClass = classMirror;
		_mirroredMethodStorage = [NSValue valueWithBytes:&aMethod objCType:@encode(Method)];
	}
	return self;
}

- (NSArray *)argumentTypes {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int numberOfArguments = method_getNumberOfArguments(self.mirroredMethod);
	for (int i = 2; i < numberOfArguments; i++) {
		char *encoding = method_copyArgumentType(self.mirroredMethod, i);
		HGTypeMirror *mirror = [HGTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
		[result addObject:mirror];
		free(encoding);
	}
	return [NSArray arrayWithArray:result];
}

- (const char *)encoding {
	return method_getTypeEncoding(self.mirroredMethod);
}

- (IMP)implementation {
	return method_getImplementation(self.mirroredMethod);
}

- (Method)mirroredMethod {
	Method method;
	[self.mirroredMethodStorage getValue:&method];
	return method;
}

- (NSUInteger)numberOfArguments {
	// we don't want to take account of self and _cmd here, hence subtract 2
	return method_getNumberOfArguments(self.mirroredMethod) - 2;
}

- (SEL)selector {
	return method_getName(self.mirroredMethod);
}

- (IMP)replaceImplementationWith:(IMP)anImplementation {
	return method_setImplementation(self.mirroredMethod, anImplementation);
}

- (HGTypeMirror *)returnType {
	char *encoding = method_copyReturnType(self.mirroredMethod);
	HGTypeMirror *mirror = [HGTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
	free(encoding);
	return mirror;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToMethodMirror:anObject];
}

- (BOOL)isEqualToMethodMirror:(HGMethodMirror *)aMethodMirror {
	return ([self.definingClass isEqual:[aMethodMirror definingClass]]) &&
		[self.mirroredMethodStorage isEqual:aMethodMirror.mirroredMethodStorage];
}

- (NSUInteger)hash {
	return [super hash] ^ [self.mirroredMethodStorage hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGMethodMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_definingClass = [_definingClass copyWithZone:zone];
	newMirror->_mirroredMethodStorage = [_mirroredMethodStorage copyWithZone:zone];
	return newMirror;
}

@end
