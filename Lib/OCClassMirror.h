#import <Foundation/Foundation.h>


@interface OCClassMirror : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Class mirroredClass;

/**
 * Answers an OCClassMirror instance reflecting aClass.
 */
- (instancetype)initWithClass:(Class)aClass;

/**
 * Answers an array of OCClassMirrors reflecting the receiver's subclasses 
 * and the receiver's descendant's subclasses.
 */
- (NSArray *)allSubclasses;

/**
 * Answers an array of OCClassMirrors reflecting the receiver's subclasses.
 */
- (NSArray *)subclasses;

@end
