#import "HGInstanceVariableInjectionVisitor.h"
#import "HGInstanceVariableMirror-Runtime.h"
#import "HGValueMirrors.h"
#import "HGClassMirror.h"


#define Write(TYPE) \
	CFTypeRef selfRef = CFBridgingRetain(self.target); \
	TYPE *ivarPtr = (TYPE *)((uint8_t *)selfRef + ivar_getOffset(self.instanceVariable.mirroredInstanceVariable)); \
	[self.value getValue:ivarPtr]; \
	CFBridgingRelease(selfRef);
	

@interface HGInstanceVariableInjectionVisitor ()

@property (nonatomic, readwrite) id value;
@property (nonatomic, readonly) HGInstanceVariableMirror *instanceVariable;
@property (nonatomic, readonly) id target;

@end


@implementation HGInstanceVariableInjectionVisitor

- (instancetype)initWithInstanceVariable:(HGInstanceVariableMirror *)instanceVariable target:(id)anObject value:(id)aValue {
	if (self = [super init]) {
		_instanceVariable = instanceVariable;
		_target = anObject;
		_value = aValue;
	}
	return self;
}

- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror {
	object_setIvar(self.target, self.instanceVariable.mirroredInstanceVariable, self.value);
}

- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror {
	object_setIvar(self.target, self.instanceVariable.mirroredInstanceVariable, self.value);
}

- (void)visitCharTypeMirror:(HGCharTypeMirror *)typeMirror {
	Write(char);
}

- (void)visitShortTypeMirror:(HGShortTypeMirror *)typeMirror {
	Write(short);
}

- (void)visitIntTypeMirror:(HGIntTypeMirror *)typeMirror {
	Write(int);
}

- (void)visitLongTypeMirror:(HGLongTypeMirror *)typeMirror {
	Write(long);
}

- (void)visitLongLongTypeMirror:(HGLongLongTypeMirror *)typeMirror {
	Write(long long);
}

- (void)visitUnsignedCharTypeMirror:(HGUnsignedCharTypeMirror *)typeMirror {
	Write(unsigned char);
}

- (void)visitUnsignedShortTypeMirror:(HGUnsignedShortTypeMirror *)typeMirror {
	Write(unsigned short);
}

- (void)visitUnsignedIntTypeMirror:(HGUnsignedIntTypeMirror *)typeMirror {
	Write(unsigned int);
}

- (void)visitUnsignedLongTypeMirror:(HGUnsignedLongTypeMirror *)typeMirror {
	Write(unsigned long);
}

- (void)visitUnsignedLongLongTypeMirror:(HGUnsignedLongLongTypeMirror *)typeMirror {
	Write(unsigned long long);
}

- (void)visitFloatTypeMirror:(HGFloatTypeMirror *)typeMirror {
	Write(float);
}

- (void)visitDoubleTypeMirror:(HGDoubleTypeMirror *)typeMirror {
	Write(double)
}

- (void)visitBoolTypeMirror:(HGBoolTypeMirror *)typeMirror {
	Write(_Bool);
}

- (void)visitCharacterStringTypeMirror:(HGCharacterStringTypeMirror *)typeMirror {
	Write(char *);
}

- (void)visitSelectorTypeMirror:(HGSelectorTypeMirror *)typeMirror {
	Write(SEL);
}

- (void)visitArrayTypeMirror:(HGArrayTypeMirror *)typeMirror {
	
}

- (void)visitStructureTypeMirror:(HGStructureTypeMirror *)typeMirror {
	Write(void);
}

- (void)visitUnionTypeMirror:(HGUnionTypeMirror *)typeMirror {
	Write(void);
}

- (void)visitBitFieldTypeMirror:(HGBitFieldTypeMirror *)typeMirror {
	Write(void);
}

- (void)visitPointerTypeMirror:(HGPointerTypeMirror *)typeMirror {
	Write(void);
}

- (void)visitUnknownTypeMirror:(HGUnknownTypeMirror *)typeMirror {
	Write(void);
}

@end
