#import "HGMethodDescriptionMirror.h"
#import "HGMethodDescriptionMirror-Runtime.h"
#import "HGProtocolMirror.h"


@interface HGMethodDescriptionMirror ()

@property (nonatomic, readonly) NSValue *mirroredMethodDescriptionStorage;

@end


@implementation HGMethodDescriptionMirror

- (instancetype)initWithDefiningProtocol:(HGProtocolMirror *)aProtocol methodDescription:(struct objc_method_description)aMethodDescription isRequired:(BOOL)isRequired isInstanceMethod:(BOOL)isInstanceMethod {
	if (self = [super init]) {
		_definingProtocol = aProtocol;
		_mirroredMethodDescriptionStorage = [NSValue valueWithBytes:&aMethodDescription objCType:@encode(struct objc_method_description)];
		_isRequired = isRequired;
		_isInstanceMethod = isInstanceMethod;
	}
	return self;
}

- (BOOL)isClassMethod {
	return !self.isInstanceMethod;
}

- (BOOL)isOptional {
	return !self.isRequired;
}

- (struct objc_method_description)mirroredMethodDescription {
	struct objc_method_description result;
	[self.mirroredMethodDescriptionStorage getValue:&result];
	return result;
}

- (NSUInteger)numberOfArguments {
	NSString *sel = NSStringFromSelector(self.mirroredMethodDescription.name);
	return [[sel componentsSeparatedByString:@":"] count] - 1;
}

- (SEL)selector {
	return self.mirroredMethodDescription.name;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToMethodDescriptionMirror:anObject];
}

- (BOOL)isEqualToMethodDescriptionMirror:(HGMethodDescriptionMirror *)aMethodDescriptionMirror {
	return [self.definingProtocol isEqual:aMethodDescriptionMirror.definingProtocol] &&
		[self.mirroredMethodDescriptionStorage isEqual:aMethodDescriptionMirror.mirroredMethodDescriptionStorage] &&
		self.isInstanceMethod == aMethodDescriptionMirror.isInstanceMethod &&
		self.isRequired == aMethodDescriptionMirror.isRequired;
}

- (NSUInteger)hash {
	return [self.definingProtocol hash] ^
		[self.mirroredMethodDescriptionStorage hash] ^
		[@(_isInstanceMethod) hash] ^
		[@(_isRequired) hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGMethodDescriptionMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_definingProtocol = [_definingProtocol copyWithZone:zone];
	newMirror->_mirroredMethodDescriptionStorage = [_mirroredMethodDescriptionStorage copyWithZone:zone];
	newMirror->_isInstanceMethod = _isInstanceMethod;
	newMirror->_isRequired = _isRequired;
	return newMirror;
}

@end
