#import <Foundation/Foundation.h>


@interface OCClassMirror : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Class mirroredClass;
@property (nonatomic, readonly) NSDictionary *methodDictionary;

/**
 * Answers an OCClassMirror instance reflecting aClass.
 */
- (instancetype)initWithClass:(Class)aClass;

/**
 * Answers an array of OCClassMirrors reflecting the receiver's mirrored subclasses
 * and the receiver's descendant's subclasses.
 */
- (NSArray *)allSubclasses;

/**
 *
 */
- (OCClassMirror *)classMirror;

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
 * Answers an array of OCClassMirrors reflecting the receiver's mirrored subclasses.
 */
- (NSArray *)subclasses;

/**
 * Answers an OCClassMirror reflecting the receiver's mirrored superclass.
 */
- (OCClassMirror *)superclass;

@end
