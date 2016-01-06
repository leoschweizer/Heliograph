#import <Foundation/Foundation.h>


@class HGInstanceVariableMirror;
@class HGPropertyMirror;


@interface HGClassMirror : NSObject

/**
 * Answers an NSArray of HGClassMirrors reflecting all the known classes of
 * the current runtime environment.
 */
+ (NSArray *)allClasses;

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
 * Answers an NSArray of HGInstanceVariableMirror instances reflecting the 
 * instance variables defined by the receiver's mirrored class.
 */
- (NSArray *)instanceVariables;

/**
 * Answers an HGInstanceVariableMirror reflecting the instance variable named
 * aName.
 */
- (HGInstanceVariableMirror *)instanceVariableNamed:(NSString *)aName;

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
 * Answers an NSArray of HGPropertyMirror instances reflecting the properties 
 * defined by the receiver's mirrored class.
 */
- (NSArray *)properties;

/**
 * Answers an HGPropertyMirror reflecting the property named aName.
 */
- (HGPropertyMirror *)propertyNamed:(NSString *)aName;

/**
 * Answers an array of HGClassMirrors reflecting the receiver's mirrored subclasses.
 */
- (NSArray *)subclasses;

/**
 * Answers an HGClassMirror reflecting the receiver's mirrored superclass.
 */
- (HGClassMirror *)superclass;

@end
