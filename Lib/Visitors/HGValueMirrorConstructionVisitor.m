#import "HGValueMirrorConstructionVisitor.h"
#import "HGValueMirrors.h"
#import "HGClassMirror.h"


@implementation HGValueMirrorConstructionVisitor

- (instancetype)initWithValue:(id)aValue {
	if (self = [super init]) {
		_value = aValue;
	}
	return self;
}

- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror {
	self.result = [[HGObjectMirror alloc] initWithValue:self.value];
}

- (void)visitClassMirror:(HGClassMirror *)classMirror {
	self.result = [[HGClassMirror alloc] initWithValue:self.value];
}

- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror {
	self.result = [[HGClassMirror alloc] initWithValue:self.value];
}

- (void)visitCharTypeMirror:(HGCharTypeMirror *)typeMirror {
	self.result = [[HGCharValueMirror alloc] initWithValue:self.value];
}

- (void)visitShortTypeMirror:(HGShortTypeMirror *)typeMirror {
	self.result = [[HGShortValueMirror alloc] initWithValue:self.value];
}

- (void)visitIntTypeMirror:(HGIntTypeMirror *)typeMirror {
	self.result = [[HGIntValueMirror alloc] initWithValue:self.value];
}

- (void)visitLongTypeMirror:(HGLongTypeMirror *)typeMirror {
	self.result = [[HGLongValueMirror alloc] initWithValue:self.value];
}

- (void)visitLongLongTypeMirror:(HGLongLongTypeMirror *)typeMirror {
	self.result = [[HGLongLongValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnsignedCharTypeMirror:(HGUnsignedCharTypeMirror *)typeMirror {
	self.result = [[HGUnsignedCharValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnsignedShortTypeMirror:(HGUnsignedShortTypeMirror *)typeMirror {
	self.result = [[HGUnsignedShortValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnsignedIntTypeMirror:(HGUnsignedIntTypeMirror *)typeMirror {
	self.result = [[HGUnsignedIntValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnsignedLongTypeMirror:(HGUnsignedLongTypeMirror *)typeMirror {
	self.result = [[HGUnsignedLongValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnsignedLongLongTypeMirror:(HGUnsignedLongLongTypeMirror *)typeMirror {
	self.result = [[HGUnsignedLongLongValueMirror alloc] initWithValue:self.value];
}

- (void)visitFloatTypeMirror:(HGFloatTypeMirror *)typeMirror {
	self.result = [[HGFloatValueMirror alloc] initWithValue:self.value];
}

- (void)visitDoubleTypeMirror:(HGDoubleTypeMirror *)typeMirror {
	self.result = [[HGDoubleValueMirror alloc] initWithValue:self.value];
}

- (void)visitBoolTypeMirror:(HGBoolTypeMirror *)typeMirror {
	self.result = [[HGBoolValueMirror alloc] initWithValue:self.value];
}

- (void)visitCharacterStringTypeMirror:(HGCharacterStringTypeMirror *)typeMirror {
	self.result = [[HGCharacterStringValueMirror alloc] initWithValue:self.value];
}

- (void)visitSelectorTypeMirror:(HGSelectorTypeMirror *)typeMirror {
	self.result = [[HGSelectorValueMirror alloc] initWithValue:self.value];
}

- (void)visitVoidTypeMirror:(HGVoidTypeMirror *)typeMirror {
	self.result = [[HGVoidValueMirror alloc] initWithValue:self.value];
}

- (void)visitArrayTypeMirror:(HGArrayTypeMirror *)typeMirror {
	self.result = [[HGArrayValueMirror alloc] initWithValue:self.value];
}

- (void)visitStructureTypeMirror:(HGStructureTypeMirror *)typeMirror {
	self.result = [[HGStructureValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnionTypeMirror:(HGUnionTypeMirror *)typeMirror {
	self.result = [[HGUnionValueMirror alloc] initWithValue:self.value];
}

- (void)visitBitFieldTypeMirror:(HGBitFieldTypeMirror *)typeMirror {
	self.result = [[HGBitFieldValueMirror alloc] initWithValue:self.value];
}

- (void)visitPointerTypeMirror:(HGPointerTypeMirror *)typeMirror {
	self.result = [[HGPointerValueMirror alloc] initWithValue:self.value];
}

- (void)visitUnknownTypeMirror:(HGUnknownTypeMirror *)typeMirror {
	self.result = [[HGUnknownValueMirror alloc] initWithValue:self.value];
}

@end
