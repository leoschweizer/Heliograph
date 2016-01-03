#import "HGTestHierarchy.h"


@implementation HGRootClass

@end


@implementation HGDescendant1

- (void)methodDefinedInDescendant1 {}

@end


@implementation HGDescendant2

@end


@implementation HGDescendant1Descendant1

+ (void)classMethodDefinedInDescendant1Descendant1 {}
- (void)methodDefinedInDescendant1Descendant1 {}

@end


@implementation HGDescendant1Descendant2

@end


@implementation HGPropertyClass

- (NSString *)property1 {
	return @"Foo";
}

@end


@implementation HGInstanceVariableClass {
	char privateIvar;
}

@synthesize propertyWithSynthesizedIvar = _propertyWithSynthesizedIvarBaz;

- (id)propertyWithoutIvar {
	return nil;
}

@end


@implementation HGTypeTestClass

@end
