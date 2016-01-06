#import "HGTypeMirrorVisitors.h"
#import "HGTypeMirrorVisitor.h"


@interface HGTypeMirrorDescriptionVisitor : NSObject <HGTypeMirrorVisitor>

@property (nonatomic, readwrite) NSString *typeDescription;

@end


@implementation HGTypeMirrorDescriptionVisitor

- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror {
	self.typeDescription = [NSString stringWithFormat:@"id"];
}

- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror {
	self.typeDescription = @"Class";
}

- (void)visitCharTypeMirror:(HGCharTypeMirror *)typeMirror {
	self.typeDescription = @"char";
}

- (void)visitShortTypeMirror:(HGShortTypeMirror *)typeMirror {
	self.typeDescription = @"short";
}

- (void)visitIntTypeMirror:(HGIntTypeMirror *)typeMirror {
	self.typeDescription = @"int";
}

- (void)visitLongTypeMirror:(HGLongTypeMirror *)typeMirror {
	self.typeDescription = @"long";
}

- (void)visitLongLongTypeMirror:(HGLongLongTypeMirror *)typeMirror {
	self.typeDescription = @"long long";
}

- (void)visitUnsignedCharTypeMirror:(HGUnsignedCharTypeMirror *)typeMirror {
	self.typeDescription = @"unsigned char";
}

- (void)visitUnsignedShortTypeMirror:(HGUnsignedShortTypeMirror *)typeMirror {
	self.typeDescription = @"unsigned short";
}

- (void)visitUnsignedIntTypeMirror:(HGUnsignedIntTypeMirror *)typeMirror {
	self.typeDescription = @"unsigned int";
}

- (void)visitUnsignedLongTypeMirror:(HGUnsignedLongTypeMirror *)typeMirror {
	self.typeDescription = @"unsigned long";
}

- (void)visitUnsignedLongLongTypeMirror:(HGUnsignedLongLongTypeMirror *)typeMirror {
	self.typeDescription = @"unsigned long long";
}

- (void)visitFloatTypeMirror:(HGFloatTypeMirror *)typeMirror {
	self.typeDescription = @"float";
}

- (void)visitDoubleTypeMirror:(HGDoubleTypeMirror *)typeMirror {
	self.typeDescription = @"double";
}

- (void)visitBoolTypeMirror:(HGBoolTypeMirror *)typeMirror {
	self.typeDescription = @"bool";
}

- (void)visitCharacterStringTypeMirror:(HGCharacterStringTypeMirror *)typeMirror {
	self.typeDescription = @"char *";
}

- (void)visitSelectorTypeMirror:(HGSelectorTypeMirror *)typeMirror {
	self.typeDescription = @"SEL";
}

- (void)visitVoidTypeMirror:(HGVoidTypeMirror *)typeMirror {
	self.typeDescription = @"void";
}

- (void)visitArrayTypeMirror:(HGArrayTypeMirror *)typeMirror {
	self.typeDescription = @"array";
}

- (void)visitStructureTypeMirror:(HGStructureTypeMirror *)typeMirror {
	self.typeDescription = @"struct";
}

- (void)visitUnionTypeMirror:(HGUnionTypeMirror *)typeMirror {
	self.typeDescription = @"union";
}

- (void)visitBitFieldTypeMirror:(HGBitFieldTypeMirror *)typeMirror {
	self.typeDescription = @"bitfield";
}

- (void)visitPointerTypeMirror:(HGPointerTypeMirror *)typeMirror {
	self.typeDescription = @"^";
}

- (void)visitUnknownTypeMirror:(HGUnknownTypeMirror *)typeMirror {
	self.typeDescription = @"unknown type";
}

@end


@implementation HGTypeMirror (HGTypeMirrorDescription)

- (NSString *)typeDescription {
	HGTypeMirrorDescriptionVisitor *visitor = [[HGTypeMirrorDescriptionVisitor alloc] init];
	[self accept:visitor];
	return visitor.typeDescription;
}

@end
