#import <Foundation/Foundation.h>


@interface OCTypeMirror : NSObject

@end


@interface OCClassMirror : OCTypeMirror

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
 * Answers YES if the mirrored class is a metaclass, otherwise NO.
 */
- (BOOL)isMetaclass;

/**
 * Answers an array of OCClassMirrors reflecting the receiver's mirrored subclasses.
 */
- (NSArray *)subclasses;

/**
 * Answers an OCClassMirror reflecting the receiver's mirrored superclass.
 */
- (OCClassMirror *)superclass;

@end
