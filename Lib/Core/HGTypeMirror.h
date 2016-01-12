#import <Foundation/Foundation.h>


@class HGObjectTypeMirror;
@class HGClassMirror;
@class HGClassTypeMirror;
@class HGCharTypeMirror;
@class HGShortTypeMirror;
@class HGIntTypeMirror;
@class HGLongTypeMirror;
@class HGLongLongTypeMirror;
@class HGUnsignedCharTypeMirror;
@class HGUnsignedShortTypeMirror;
@class HGUnsignedIntTypeMirror;
@class HGUnsignedLongTypeMirror;
@class HGUnsignedLongLongTypeMirror;
@class HGFloatTypeMirror;
@class HGDoubleTypeMirror;
@class HGBoolTypeMirror;
@class HGCharacterStringTypeMirror;
@class HGSelectorTypeMirror;
@class HGVoidTypeMirror;
@class HGArrayTypeMirror;
@class HGStructureTypeMirror;
@class HGUnionTypeMirror;
@class HGBitFieldTypeMirror;
@class HGPointerTypeMirror;
@class HGUnknownTypeMirror;
@protocol HGTypeMirrorVisitor;


@protocol HGTypeMirror <NSObject, NSCopying>

/**
 * Executes aVisitor on the receiver.
 */
- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor;

/**
 * Answers a human readable description of the receiver's mirrored type.
 */
- (NSString *)typeDescription;

/**
 * Compares the receiving id<HGTypeMirror> to another id<HGTypeMirror>.
 */
- (BOOL)isEqualToTypeMirror:(id<HGTypeMirror>)aTypeMirror;

@end


@protocol HGTypeMirrorVisitor <NSObject>

@optional
- (void)visitObjectTypeMirror:(HGObjectTypeMirror *)typeMirror;
- (void)visitClassMirror:(HGClassMirror *)classMirror;
- (void)visitClassTypeMirror:(HGClassTypeMirror *)typeMirror;
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
