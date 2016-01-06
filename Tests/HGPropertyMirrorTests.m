#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGPropertyMirrorTests : XCTestCase

@end


@implementation HGPropertyMirrorTests

- (void)testName {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property1"];
	XCTAssertEqualObjects([mirror name], @"property1");
}

- (void)testProperty1 {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property1"];
	XCTAssertNotNil(mirror);
	XCTAssertTrue([mirror isReadonly]);
	XCTAssertTrue([mirror isCopied]);
	XCTAssertTrue([mirror isNonatomic]);
	XCTAssertFalse([mirror isGarbageCollected]);
	XCTAssertFalse([mirror isDynamic]);
	XCTAssertFalse([mirror isWeak]);
	XCTAssertFalse([mirror isRetained]);
}

- (void)testProperty2 {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property2"];
	XCTAssertNotNil(mirror);
	XCTAssertFalse([mirror isReadonly]);
	XCTAssertFalse([mirror isCopied]);
	XCTAssertFalse([mirror isNonatomic]);
	XCTAssertFalse([mirror isGarbageCollected]);
	XCTAssertFalse([mirror isDynamic]);
	XCTAssertTrue([mirror isWeak]);
	XCTAssertFalse([mirror isRetained]);
}

- (void)testPropertyBaz {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"baz"];
	XCTAssertNotNil(mirror);
}

- (void)testBackingInstanceVariable {
	HGPropertyMirror *property = [reflect([HGPropertyClass class]) propertyNamed:@"property2"];
	HGInstanceVariableMirror *instanceVariable = [property backingInstanceVariable];
	XCTAssertNotNil(instanceVariable);
	XCTAssertEqualObjects(instanceVariable.name, @"_property2");
}

- (void)testBackingInstanceVariableMissing {
	HGPropertyMirror *property = [reflect([HGPropertyClass class]) propertyNamed:@"property1"];
	HGInstanceVariableMirror *instanceVariable = [property backingInstanceVariable];
	XCTAssertNil(instanceVariable);
}

- (void)testGetter {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property1"];
	HGMethodMirror *getter = [mirror getter];
	XCTAssertNotNil(getter);
	XCTAssertEqual([getter selector], @selector(property1));
}

- (void)testSetterMissing {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property1"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNil(setter);
}

- (void)testCustomGetter {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"baz"];
	HGMethodMirror *getter = [mirror getter];
	XCTAssertNotNil(getter);
	XCTAssertEqual([getter selector], @selector(getBar));
}

- (void)testSetter {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"property2"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNotNil(setter);
	XCTAssertEqual([setter selector], @selector(setProperty2:));
}

- (void)testCustomSetter {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"baz"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNotNil(setter);
	XCTAssertEqual([setter selector], @selector(setFoo:));
}

- (void)testGetMissingProperty {
	HGPropertyMirror *mirror = [reflect([HGPropertyClass class]) propertyNamed:@"missing"];
	XCTAssertNil(mirror);
}

@end
