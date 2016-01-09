#import "HGInstanceVariableMirror.h"
#import "HGInstanceVariableMirror-Runtime.h"
#import "HGClassMirror.h"
#import "HGTypeMirrors.h"
#import "HGInstanceVariableExtractionVisitor.h"


@interface HGInstanceVariableMirror ()

@property (nonatomic, readonly) NSValue *mirroredInstanceVariableStorage;

@end


@implementation HGInstanceVariableMirror

- (instancetype)initWithDefiningClass:(HGClassMirror *)definingClass instanceVariable:(Ivar)instanceVariable {
	if (self = [super init]) {
		_mirroredInstanceVariableStorage = [NSValue valueWithBytes:&instanceVariable objCType:@encode(Ivar)];
		_definingClass = definingClass;
	}
	return self;
}

- (Ivar)mirroredInstanceVariable {
	Ivar ivar;
	[self.mirroredInstanceVariableStorage getValue:&ivar];
	return ivar;
}

- (NSString *)name {
	return [NSString stringWithUTF8String:ivar_getName(self.mirroredInstanceVariable)];
}

- (HGBaseTypeMirror *)type {
	const char *encoding = ivar_getTypeEncoding(self.mirroredInstanceVariable);
	return [HGBaseTypeMirror createForEncoding:[NSString stringWithUTF8String:encoding]];
}

- (id<HGValueMirror>)valueIn:(id)anObject {
	HGInstanceVariableExtractionVisitor *visitor = [[HGInstanceVariableExtractionVisitor alloc] initWithInstanceVariable:self target:anObject];
	[self.type acceptTypeMirrorVisitor:visitor];
	return visitor.value;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToInstanceVariableMirror:anObject];
}

- (BOOL)isEqualToInstanceVariableMirror:(HGInstanceVariableMirror *)anInstanceVariableMirror {
	return ([self.definingClass isEqualToClassMirror:anInstanceVariableMirror.definingClass]) &&
		[self.mirroredInstanceVariableStorage isEqual:anInstanceVariableMirror.mirroredInstanceVariableStorage];
}

- (NSUInteger)hash {
	return [self.definingClass hash] ^ [self.mirroredInstanceVariableStorage hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGInstanceVariableMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_definingClass = [_definingClass copyWithZone:zone];
	newMirror->_mirroredInstanceVariableStorage = [_mirroredInstanceVariableStorage copyWithZone:zone];
	return newMirror;
}

@end
