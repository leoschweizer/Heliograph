#import <Foundation/Foundation.h>


@interface HGClassMirror : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Class mirroredClass;
@property (nonatomic, readonly) NSDictionary *methodDictionary;

/**
 * Answers an HGClassMirror instance reflecting aClass.
 */
- (instancetype)initWithClass:(Class)aClass;

/**
 * Answers an array of HGClassMirrors reflecting the receiver's mirrored subclasses
 * and the receiver's descendant's subclasses.
 */
- (NSArray *)allSubclasses;

/**
 *
 */
- (HGClassMirror *)classMirror;

/**
 *
 */
- (NSDictionary *)instanceVariables;

/**
 * Answers YES if the mirrored class is a metaclass, otherwise NO.
 */
- (BOOL)isMetaclass;

/**
 *
 */
- (NSDictionary *)properties;

/**
 * Answers an array of HGClassMirrors reflecting the receiver's mirrored subclasses.
 */
- (NSArray *)subclasses;

/**
 * Answers an HGClassMirror reflecting the receiver's mirrored superclass.
 */
- (HGClassMirror *)superclass;

@end
