#import <Foundation/Foundation.h>
#import "HGTypeMirrors.h"


@protocol HGTypeMirrorVisitor <NSObject>

@optional
- (void)visitTypeMirror:(HGTypeMirror *)typeMirror;
- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror;
- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror;
- (void)visitPrimitiveTypeMirror:(HGPrimitiveTypeMirror *)typeMirror;
- (void)visitCharTypeMirror:(HGCharTypeMirror *)typeMirror;
- (void)visitShortTypeMirror:(HGShortTypeMirror *)typeMirror;
- (void)visitIntTypeMirror:(HGIntTypeMirror *)typeMirror;
- (void)visitLongTypeMirror:(HGLongTypeMirror *)typeMirror;
- (void)visitLongLongTypeMirror:(HGLongLongTypeMirror *)typeMirror;
- (void)visitUnsignedCharTypeMirror:(HGUnsignedCharTypeMirror *)typeMirror;
- (void)visitUnsignedShortTypeMirror:(HGUnsignedShortTypeMirror *)typeMirror;
- (void)visitUnsignedIntTypeMirror:(HGUnsignedIntTypeMirror *)typeMirror;
- (void)visitUnsignedLongTypeMirror:(HGUnsignedLongTypeMirror *)typeMirror;
- (void)visitUnsignedLongLongTypeMirror:(HGUnsignedLongLongTypeMirror *)typeMirror;
- (void)visitFloatTypeMirror:(HGFloatTypeMirror *)typeMirror;
- (void)visitDoubleTypeMirror:(HGDoubleTypeMirror *)typeMirror;
- (void)visitBoolTypeMirror:(HGBoolTypeMirror *)typeMirror;
- (void)visitCharacterStringTypeMirror:(HGCharacterStringTypeMirror *)typeMirror;
- (void)visitSelectorTypeMirror:(HGSelectorTypeMirror *)typeMirror;
- (void)visitVoidTypeMirror:(HGVoidTypeMirror *)typeMirror;
- (void)visitArrayTypeMirror:(HGArrayTypeMirror *)typeMirror;
- (void)visitStructureTypeMirror:(HGStructureTypeMirror *)typeMirror;
- (void)visitUnionTypeMirror:(HGUnionTypeMirror *)typeMirror;
- (void)visitBitFieldTypeMirror:(HGBitFieldTypeMirror *)typeMirror;
- (void)visitPointerTypeMirror:(HGPointerTypeMirror *)typeMirror;
- (void)visitUnknownTypeMirror:(HGUnknownTypeMirror *)typeMirror;

@end


@interface HGTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor;

@end
