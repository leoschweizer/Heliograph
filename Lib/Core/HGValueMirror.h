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

@end


@protocol HGValueMirrorVisitor <NSObject>

@optional
- (void)visitObjectValueMirror:(HGObjectMirror *)ValueMirror;
- (void)visitClassMirror:(HGClassMirror *)classMirror;
- (void)visitCharValueMirror:(HGCharValueMirror *)ValueMirror;
- (void)visitShortValueMirror:(HGShortValueMirror *)ValueMirror;
- (void)visitIntValueMirror:(HGIntValueMirror *)ValueMirror;
- (void)visitLongValueMirror:(HGLongValueMirror *)ValueMirror;
- (void)visitLongLongValueMirror:(HGLongLongValueMirror *)ValueMirror;
- (void)visitUnsignedCharValueMirror:(HGUnsignedCharValueMirror *)ValueMirror;
- (void)visitUnsignedShortValueMirror:(HGUnsignedShortValueMirror *)ValueMirror;
- (void)visitUnsignedIntValueMirror:(HGUnsignedIntValueMirror *)ValueMirror;
- (void)visitUnsignedLongValueMirror:(HGUnsignedLongValueMirror *)ValueMirror;
- (void)visitUnsignedLongLongValueMirror:(HGUnsignedLongLongValueMirror *)ValueMirror;
- (void)visitFloatValueMirror:(HGFloatValueMirror *)ValueMirror;
- (void)visitDoubleValueMirror:(HGDoubleValueMirror *)ValueMirror;
- (void)visitBoolValueMirror:(HGBoolValueMirror *)ValueMirror;
- (void)visitCharacterStringValueMirror:(HGCharacterStringValueMirror *)ValueMirror;
- (void)visitSelectorValueMirror:(HGSelectorValueMirror *)ValueMirror;
- (void)visitVoidValueMirror:(HGVoidValueMirror *)ValueMirror;
- (void)visitArrayValueMirror:(HGArrayValueMirror *)ValueMirror;
- (void)visitStructureValueMirror:(HGStructureValueMirror *)ValueMirror;
- (void)visitUnionValueMirror:(HGUnionValueMirror *)ValueMirror;
- (void)visitBitFieldValueMirror:(HGBitFieldValueMirror *)ValueMirror;
- (void)visitPointerValueMirror:(HGPointerValueMirror *)ValueMirror;
- (void)visitUnknownValueMirror:(HGUnknownValueMirror *)ValueMirror;

@end
