#import "HGProtocolMirror.h"
#import <objc/runtime.h>
#import "HGMethodDescriptionMirror-Runtime.h"
#import "HGPropertyMirror-Runtime.h"


@interface HGProtocolMirror ()

@property (nonatomic, readonly) NSValue *mirroredProtocolStorage;

@end


@implementation HGProtocolMirror

+ (HGProtocolMirror *)addProtocolNamed:(NSString *)aName {
	Protocol *newProtocol = objc_allocateProtocol([aName UTF8String]);
	if (!newProtocol) {
		return nil;
	}
	return [[self alloc] initWithProtocol:newProtocol];
}

+ (NSArray *)allProtocols {
	unsigned int protocolCount;
	Protocol * __unsafe_unretained *protocols = objc_copyProtocolList(&protocolCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:protocolCount];
	for(int i = 0; i < protocolCount; i++) {
		[result addObject:[[self alloc] initWithProtocol:protocols[i]]];
	}
	free(protocols);
	return [NSArray arrayWithArray:result];
}

- (instancetype)initWithProtocol:(Protocol *)aProtocol {
	if (self = [super init]) {
		_mirroredProtocolStorage = [NSValue valueWithNonretainedObject:aProtocol];
	}
	return self;
}

- (NSArray *)adoptedProtocols {
	NSMutableArray *result = [NSMutableArray array];
	unsigned int protocolCount = 0;
	Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(self.mirroredProtocol, &protocolCount);
	for (int i = 0; i < protocolCount; i++) {
		Protocol *protocol = protocols[i];
		HGProtocolMirror *mirror = [[HGProtocolMirror alloc] initWithProtocol:protocol];
		[result addObject:mirror];
	}
	free(protocols);
	return [NSArray arrayWithArray:result];
}

- (HGProtocolMirror *)adoptProtocol:(Protocol *)aProtocol {
	if (protocol_conformsToProtocol(self.mirroredProtocol, aProtocol)) {
		return nil;
	}
	protocol_addProtocol(self.mirroredProtocol, aProtocol);
	if (protocol_conformsToProtocol(self.mirroredProtocol, aProtocol)) {
		return [[HGProtocolMirror alloc] initWithProtocol:aProtocol];
	}
	return nil;
}

- (NSArray *)getMethods:(BOOL)isInstanceMethod {
	unsigned int requiredMethodCount;
	unsigned int optionalMethodCount;
	struct objc_method_description *requiredMethods = protocol_copyMethodDescriptionList(self.mirroredProtocol, YES, isInstanceMethod, &requiredMethodCount);
	struct objc_method_description *optionalMethods = protocol_copyMethodDescriptionList(self.mirroredProtocol, NO, isInstanceMethod, &optionalMethodCount);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:requiredMethodCount + optionalMethodCount];
	for (int i = 0; i < requiredMethodCount; i++) {
		struct objc_method_description description = requiredMethods[i];
		HGMethodDescriptionMirror *mirror = [[HGMethodDescriptionMirror alloc] initWithDefiningProtocol:self methodDescription:description isRequired:YES isInstanceMethod:isInstanceMethod];
		[result addObject:mirror];
	}
	for (int i = 0; i < optionalMethodCount; i++) {
		struct objc_method_description description = optionalMethods[i];
		HGMethodDescriptionMirror *mirror = [[HGMethodDescriptionMirror alloc] initWithDefiningProtocol:self methodDescription:description isRequired:NO isInstanceMethod:isInstanceMethod];
		[result addObject:mirror];
	}
	free(requiredMethods);
	free(optionalMethods);
	return result;
}

- (Protocol *)mirroredProtocol {
	return [self.mirroredProtocolStorage nonretainedObjectValue];
}

- (NSString *)name {
	return [NSString stringWithUTF8String:protocol_getName(self.mirroredProtocol)];
}

- (HGMethodDescriptionMirror *)instanceMethodNamed:(SEL)aName {
	NSArray *instanceMethods = [self instanceMethods];
	for (HGMethodDescriptionMirror *each in instanceMethods) {
		if (sel_isEqual([each selector], aName)) {
			return each;
		}
	}
	return nil;
}

- (NSArray *)instanceMethods {
	return [self getMethods:YES];
}

- (HGMethodDescriptionMirror *)classMethodNamed:(SEL)aName {
	NSArray *classMethods = [self classMethods];
	for (HGMethodDescriptionMirror *each in classMethods) {
		if (sel_isEqual([each selector], aName)) {
			return each;
		}
	}
	return nil;
}

- (NSArray *)classMethods {
	return [self getMethods:NO];
}

- (NSArray *)properties {
	unsigned int numberOfProperties;
	objc_property_t *properties = protocol_copyPropertyList(self.mirroredProtocol, &numberOfProperties);
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:numberOfProperties];
	for (int i = 0; i < numberOfProperties; i++) {
		objc_property_t property = properties[i];
		HGPropertyMirror *mirror = [[HGPropertyMirror alloc] initWithDefiningProtocol:self property:property];
		[result addObject:mirror];
	}
	free(properties);
	return result;
}

- (void)registerProtocol {
	objc_registerProtocol(self.mirroredProtocol);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToProtocolMirror:anObject];
}

- (BOOL)isEqualToProtocolMirror:(HGProtocolMirror *)aProtocolMirror {
	return [self.mirroredProtocolStorage isEqual:aProtocolMirror.mirroredProtocolStorage];
}

- (NSUInteger)hash {
	return [@"HGProtocolMirror" hash] ^ [self.mirroredProtocolStorage hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGProtocolMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_mirroredProtocolStorage = [_mirroredProtocolStorage copyWithZone:zone];
	return newMirror;
}

@end
