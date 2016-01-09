#import <Foundation/Foundation.h>


@class HGObjectMirror;
@class HGClassMirror;
@class HGCharValueMirror;
@class HGShortValueMirror;
@class HGIntValueMirror;
@class HGLongValueMirror;
@class HGLongLongValueMirror;
@class HGUnsignedCharValueMirror;
@class HGUnsignedShortValueMirror;
@class HGUnsignedIntValueMirror;
@class HGUnsignedLongValueMirror;
@class HGUnsignedLongLongValueMirror;
@class HGFloatValueMirror;
@class HGDoubleValueMirror;
@class HGBoolValueMirror;
@class HGCharacterStringValueMirror;
@class HGSelectorValueMirror;
@class HGVoidValueMirror;
@class HGArrayValueMirror;
@class HGStructureValueMirror;
@class HGUnionValueMirror;
@class HGBitFieldValueMirror;
@class HGPointerValueMirror;
@class HGUnknownValueMirror;
@protocol HGValueMirrorVisitor;


@protocol HGValueMirror <NSObject>

@property (nonatomic, readonly) NSValue *mirroredValue;

- (void)acceptValueMirrorVisitor:(id<HGValueMirrorVisitor>)aVisitor;

- (NSString *)valueDescription;

@end


@protocol HGValueMirrorVisitor <NSObject>

@optional
- (void)visitObjectValueMirror:(HGObjectMirror *)valueMirror;
- (void)visitClassMirror:(HGClassMirror *)classMirror;
- (void)visitCharValueMirror:(HGCharValueMirror *)valueMirror;
- (void)visitShortValueMirror:(HGShortValueMirror *)valueMirror;
- (void)visitIntValueMirror:(HGIntValueMirror *)valueMirror;
- (void)visitLongValueMirror:(HGLongValueMirror *)valueMirror;
- (void)visitLongLongValueMirror:(HGLongLongValueMirror *)valueMirror;
- (void)visitUnsignedCharValueMirror:(HGUnsignedCharValueMirror *)valueMirror;
- (void)visitUnsignedShortValueMirror:(HGUnsignedShortValueMirror *)valueMirror;
- (void)visitUnsignedIntValueMirror:(HGUnsignedIntValueMirror *)valueMirror;
- (void)visitUnsignedLongValueMirror:(HGUnsignedLongValueMirror *)valueMirror;
- (void)visitUnsignedLongLongValueMirror:(HGUnsignedLongLongValueMirror *)valueMirror;
- (void)visitFloatValueMirror:(HGFloatValueMirror *)valueMirror;
- (void)visitDoubleValueMirror:(HGDoubleValueMirror *)valueMirror;
- (void)visitBoolValueMirror:(HGBoolValueMirror *)valueMirror;
- (void)visitCharacterStringValueMirror:(HGCharacterStringValueMirror *)valueMirror;
- (void)visitSelectorValueMirror:(HGSelectorValueMirror *)valueMirror;
- (void)visitArrayValueMirror:(HGArrayValueMirror *)valueMirror;
- (void)visitStructureValueMirror:(HGStructureValueMirror *)valueMirror;
- (void)visitUnionValueMirror:(HGUnionValueMirror *)valueMirror;
- (void)visitBitFieldValueMirror:(HGBitFieldValueMirror *)valueMirror;
- (void)visitPointerValueMirror:(HGPointerValueMirror *)valueMirror;
- (void)visitUnknownValueMirror:(HGUnknownValueMirror *)valueMirror;

@end
