#import "HGInstanceVariableExtractionVisitor.h"
#import "HGInstanceVariableMirror-Runtime.h"
#import "HGValueMirrors.h"
#import "HGClassMirror.h"


@interface HGInstanceVariableExtractionVisitor ()

@property (nonatomic, readwrite) id<HGValueMirror> value;
@property (nonatomic, readonly) HGInstanceVariableMirror *instanceVariable;
@property (nonatomic, readonly) id target;

@end


@implementation HGInstanceVariableExtractionVisitor

- (instancetype)initWithInstanceVariable:(HGInstanceVariableMirror *)instanceVariable target:(id)anObject {
	if (self = [super init]) {
		_instanceVariable = instanceVariable;
		_target = anObject;
	}
	return self;
}

- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror {
	id value = object_getIvar(self.target, self.instanceVariable.mirroredInstanceVariable);
	self.value = [[HGObjectMirror alloc] initWithObject:value];
}

- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror {
	id value = object_getIvar(self.target, self.instanceVariable.mirroredInstanceVariable);
	self.value = [[HGClassMirror alloc] initWithClass:value];
}

- (NSValue *)getPrimitiveValue {
	CFTypeRef targetRef = CFBridgingRetain(self.target);
	void *value = (void *)((uint8_t *)targetRef + ivar_getOffset(self.instanceVariable.mirroredInstanceVariable));
	CFBridgingRelease(targetRef);
	return [NSValue valueWithBytes:value objCType:ivar_getTypeEncoding(self.instanceVariable.mirroredInstanceVariable)];
}

- (void)visitCharTypeMirror:(HGCharTypeMirror *)typeMirror {
	self.value = [[HGCharValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitShortTypeMirror:(HGShortTypeMirror *)typeMirror {
	self.value = [[HGShortValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitIntTypeMirror:(HGIntTypeMirror *)typeMirror {
	self.value = [[HGIntValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitLongTypeMirror:(HGLongTypeMirror *)typeMirror {
	self.value = [[HGLongValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitLongLongTypeMirror:(HGLongLongTypeMirror *)typeMirror {
	self.value = [[HGLongLongValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnsignedCharTypeMirror:(HGUnsignedCharTypeMirror *)typeMirror {
	self.value = [[HGUnsignedCharValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnsignedShortTypeMirror:(HGUnsignedShortTypeMirror *)typeMirror {
	self.value = [[HGUnsignedShortValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnsignedIntTypeMirror:(HGUnsignedIntTypeMirror *)typeMirror {
	self.value = [[HGUnsignedIntValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnsignedLongTypeMirror:(HGUnsignedLongTypeMirror *)typeMirror {
	self.value = [[HGUnsignedLongValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnsignedLongLongTypeMirror:(HGUnsignedLongLongTypeMirror *)typeMirror {
	self.value = [[HGUnsignedLongLongValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitFloatTypeMirror:(HGFloatTypeMirror *)typeMirror {
	self.value = [[HGFloatValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitDoubleTypeMirror:(HGDoubleTypeMirror *)typeMirror {
	self.value = [[HGDoubleValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitBoolTypeMirror:(HGBoolTypeMirror *)typeMirror {
	self.value = [[HGBoolValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitCharacterStringTypeMirror:(HGCharacterStringTypeMirror *)typeMirror {
	self.value = [[HGCharacterStringValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitSelectorTypeMirror:(HGSelectorTypeMirror *)typeMirror {
	self.value = [[HGSelectorValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitArrayTypeMirror:(HGArrayTypeMirror *)typeMirror {
	self.value = [[HGArrayValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitStructureTypeMirror:(HGStructureTypeMirror *)typeMirror {
	self.value = [[HGStructureValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnionTypeMirror:(HGUnionTypeMirror *)typeMirror {
	self.value = [[HGUnionValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitPointerTypeMirror:(HGPointerTypeMirror *)typeMirror {
	self.value = [[HGPointerValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

- (void)visitUnknownTypeMirror:(HGUnknownTypeMirror *)typeMirror {
	self.value = [[HGUnknownValueMirror alloc] initWithValue:[self getPrimitiveValue]];
}

@end
