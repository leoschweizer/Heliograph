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

- (instancetype)init {
	if (self = [super init]) {
		rectIvar = CGRectMake(1337, 42, 100, 100);
	}
	return self;
}

- (id)propertyWithoutIvar {
	return nil;
}

@end


@implementation HGTypeTestClass

@end


@implementation HGWrapperTestClass

- (int)testMethodWithArg:(int)arg {
	return arg * 2;
}

@end
