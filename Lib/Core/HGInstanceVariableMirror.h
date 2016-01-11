#import <Foundation/Foundation.h>


@class HGClassMirror;
@protocol HGTypeMirror;
@protocol HGValueMirror;


@interface HGInstanceVariableMirror : NSObject <NSCopying>

/**
 * The HGClassMirror reflecting the receiver's mirrored instance variables'
 * defining class.
 */
@property (nonatomic, readonly) HGClassMirror *definingClass;

/**
 * Answers the name of the receiver's mirrored instance variable.
 */
- (NSString *)name;

/**
 * Writes aValue into the receiver's mirrored instance variable in anObject.
 * Primitive types (e.g. int, BOOL, CGRect, ...) have to be wrapped as NSValue
 * instances, e.g. [NSValue valueWithBytes:&rect encoding:@encode(CGRect)].
 */
- (void)setValue:(id)aValue in:(id)anObject;

/**
 * Answers an HGTypeMirror reflecting the receiver's mirrored instance 
 * variable's type.
 */
- (id<HGTypeMirror>)type;

/**
 * Answers an HGValueMirror reflecting the value of the receiver's mirrored
 * instance variable in anObject.
 */
- (id<HGValueMirror>)valueIn:(id)anObject;

/**
 * Compares the receiving HGInstanceVariableMirror to another HGInstanceVariableMirror.
 */
- (BOOL)isEqualToInstanceVariableMirror:(HGInstanceVariableMirror *)anInstanceVariableMirror;

@end
