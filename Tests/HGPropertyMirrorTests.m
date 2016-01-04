#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGPropertyMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSDictionary *properties;

@end


@implementation HGPropertyMirrorTests

- (void)setUp {
	self.properties = [reflect([HGPropertyClass class]) properties];
}

- (void)testName {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	XCTAssertEqualObjects([mirror name], @"property1");
}

- (void)testProperty1 {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
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
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property2"];
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
	HGPropertyMirror *mirror = [self.properties objectForKey:@"baz"];
	XCTAssertNotNil(mirror);
}

- (void)testBackingInstanceVariable {
	HGPropertyMirror *property = [self.properties objectForKey:@"property2"];
	HGInstanceVariableMirror *instanceVariable = [property backingInstanceVariable];
	XCTAssertNotNil(instanceVariable);
	XCTAssertEqualObjects(instanceVariable.name, @"_property2");
}

- (void)testBackingInstanceVariableMissing {
	HGPropertyMirror *property = [self.properties objectForKey:@"property1"];
	HGInstanceVariableMirror *instanceVariable = [property backingInstanceVariable];
	XCTAssertNil(instanceVariable);
}

- (void)testGetter {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	HGMethodMirror *getter = [mirror getter];
	XCTAssertNotNil(getter);
	XCTAssertEqual([getter selector], @selector(property1));
}

- (void)testSetterMissing {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNil(setter);
}

- (void)testCustomGetter {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"baz"];
	HGMethodMirror *getter = [mirror getter];
	XCTAssertNotNil(getter);
	XCTAssertEqual([getter selector], @selector(getBar));
}

- (void)testSetter {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"property2"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNotNil(setter);
	XCTAssertEqual([setter selector], @selector(setProperty2:));
}

- (void)testCustomSetter {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"baz"];
	HGMethodMirror *setter = [mirror setter];
	XCTAssertNotNil(setter);
	XCTAssertEqual([setter selector], @selector(setFoo:));
}

@end
