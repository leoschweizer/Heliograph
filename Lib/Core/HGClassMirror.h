#import <Foundation/Foundation.h>


@interface HGClassMirror : NSObject

/**
 * The mirrored class.
 */
@property (nonatomic, readonly) Class mirroredClass;

/**
 * Answers an HGClassMirror instance reflecting aClass.
 */
- (instancetype)initWithClass:(Class)aClass;

/**
 * Answers an NSArray of OCProtocolMirrors reflecting the protocols adopted
 * by the receiver's mirrored class.
 */
- (NSArray *)adoptedProtocols;

/**
 * Answers an array of HGClassMirrors reflecting the receiver's mirrored subclasses
 * and the receiver's descendant's subclasses.
 */
- (NSArray *)allSubclasses;

/**
 * Answers an HGClassMirror reflecting the class of the receiver's mirrored 
 * class (that is, the metaclass).
 */
- (HGClassMirror *)classMirror;

/**
 * Answers an NSDictionary mapping instance variable names to HGInstanceVariableMirror
 * instances reflecting the instance variables defined by the receiver's mirrored class.
 */
- (NSDictionary *)instanceVariables;

/**
 * Answers YES if the mirrored class is a metaclass, otherwise NO.
 */
- (BOOL)isMetaclass;

/**
 * Answers an NSDictionary mapping selector names to HGMethodMirror instances
 * reflecting the methods defined by the receiver's mirrored class.
 */
- (NSDictionary *)methods;

/**
 * Answers the name of the receiver's mirrored class.
 */
- (NSString *)name;

/**
 * Answers an NSDictionary mapping property names to HGPropertyMirror instances
 * reflecting the properties defined by the receiver's mirrored class.
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
