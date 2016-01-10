#import "HGValueMirrorDescriptionVisitor.h"
#import "HGValueMirrors.h"
#import "HGClassMirror.h"


@implementation HGValueMirrorDescriptionVisitor

- (void)visitObjectValueMirror:(HGObjectMirror *)valueMirror {
	self.valueDescription = [valueMirror.mirroredObject description];
}

- (void)visitClassMirror:(HGClassMirror *)classMirror {
	self.valueDescription = [classMirror typeDescription];
}

- (void)visitCharValueMirror:(HGCharValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%i", [valueMirror charValue]];
}

- (void)visitShortValueMirror:(HGShortValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%hd", [valueMirror shortValue]];
}

- (void)visitIntValueMirror:(HGIntValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%i", [valueMirror intValue]];
}

- (void)visitLongValueMirror:(HGLongValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%ld", [valueMirror longValue]];
}

- (void)visitLongLongValueMirror:(HGLongLongValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%lld", [valueMirror longLongValue]];
}

- (void)visitUnsignedCharValueMirror:(HGUnsignedCharValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%i", [valueMirror unsignedCharValue]];
}

- (void)visitUnsignedShortValueMirror:(HGUnsignedShortValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%hd", [valueMirror unsignedShortValue]];
}

- (void)visitUnsignedIntValueMirror:(HGUnsignedIntValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%i", [valueMirror unsignedIntValue]];
}

- (void)visitUnsignedLongValueMirror:(HGUnsignedLongValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%lu", [valueMirror unsignedLongValue]];
}

- (void)visitUnsignedLongLongValueMirror:(HGUnsignedLongLongValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%llu", [valueMirror unsignedLongLongValue]];
}

- (void)visitFloatValueMirror:(HGFloatValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%g", [valueMirror floatValue]];
}

- (void)visitDoubleValueMirror:(HGDoubleValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%g", [valueMirror doubleValue]];
}

- (void)visitSelectorValueMirror:(HGSelectorValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%@", NSStringFromSelector([valueMirror selectorValue])];
}

- (void)visitCharacterStringValueMirror:(HGCharacterStringValueMirror *)valueMirror {
	self.valueDescription = [NSString stringWithFormat:@"%s", [valueMirror characterStringValue]];
}

- (void)visitBoolValueMirror:(HGBoolValueMirror *)valueMirror {
	self.valueDescription = [valueMirror boolValue] ? @"true" : @"false";
}

- (void)visitArrayValueMirror:(HGArrayValueMirror *)valueMirror {
	self.valueDescription = @"[array]";
}

- (void)visitStructureValueMirror:(HGStructureValueMirror *)valueMirror {
	self.valueDescription = @"{struct}";
}

- (void)visitUnionValueMirror:(HGUnionValueMirror *)valueMirror {
	self.valueDescription = @"(union)";
}

- (void)visitPointerValueMirror:(HGPointerValueMirror *)valueMirror {
	self.valueDescription = @"<^>";
}

- (void)visitBitFieldValueMirror:(HGBitFieldValueMirror *)valueMirror {
	self.valueDescription = @"<bitfield>";
}

- (void)visitUnknownValueMirror:(HGUnknownValueMirror *)valueMirror {
	self.valueDescription = @"<unknown>";
}

@end
