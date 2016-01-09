#import <Foundation/Foundation.h>


@class HGClassMirror;
@protocol HGTypeMirror;


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
 * Answers an HGTypeMirror reflecting the receiver's mirrored instance 
 * variable's type.
 */
- (id<HGTypeMirror>)type;

/**
 * Compares the receiving HGInstanceVariableMirror to another HGInstanceVariableMirror.
 */
- (BOOL)isEqualToInstanceVariableMirror:(HGInstanceVariableMirror *)anInstanceVariableMirror;

@end
