#import <Foundation/Foundation.h>


@class HGClassMirror;
@class HGTypeMirror;


@interface HGInstanceVariableMirror : NSObject

/**
 * The HGClassMirror reflecting the receiver's mirrored instance variables'
 * defining class.
 */
@property (nonatomic, readonly) HGClassMirror *definingClass;

/**
 * The name of the receiver's mirrored instance variable.
 */
@property (nonatomic, readonly) NSString *name;

/**
 * Answers an HGTypeMirror reflecting the receiver's mirrored instance 
 * variable's type.
 */
- (HGTypeMirror *)type;

@end
