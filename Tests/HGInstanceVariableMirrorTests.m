#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGInstanceVariableMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSArray *instanceVariables;

@end


@implementation HGInstanceVariableMirrorTests

- (void)setUp {
	[super setUp];
	self.instanceVariables = [reflect([HGInstanceVariableClass class]) instanceVariables];
}

- (void)testInstanceVariableCount {
	XCTAssertEqual([self.instanceVariables count], 5);
}

- (void)testInstanceVariableName {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"publicIvar"];
	XCTAssertNotNil(mirror);
	XCTAssertEqualObjects(mirror.name, @"publicIvar");
}

- (void)testPrivateInstanceVariables {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testAutoSynthesizedInstanceVariable {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testReadonlyProperty {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithoutIvar"];
	XCTAssertNil(mirror);
}

- (void)testSynthesizedInstanceVariable {
	HGInstanceVariableMirror *mirror1 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"];
	XCTAssertNotNil(mirror1);
	HGInstanceVariableMirror *mirror2 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"propertyWithSynthesizedIvar"];
	XCTAssertNil(mirror2);
}

- (void)testInstanceVariableType {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	XCTAssertEqual([[mirror type] class], [HGCharTypeMirror class]);
}

- (void)testGetMissingInstanceVariable {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"missing"];
	XCTAssertNil(mirror);
}

- (void)testIsEqual {
	HGInstanceVariableMirror *m1 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	HGInstanceVariableMirror *m2 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	HGInstanceVariableMirror *m3 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"];
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
}

- (void)testHash {
	NSDictionary *test = @{
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"] : @1,
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"] : @2,
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"] : @3
	};
	XCTAssertEqual([test count], 2);
}

- (void)testRectValue {
	HGClassMirror *class = reflect([HGInstanceVariableClass class]);
	HGInstanceVariableMirror *ivar = [class instanceVariableNamed:@"rectIvar"];
	id testObject = [[HGInstanceVariableClass alloc] init];
	id<HGValueMirror> value = [ivar valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGStructureValueMirror class]]);
	CGRect rect = *(CGRect *)value.value;
	XCTAssertTrue(CGRectEqualToRect(rect, CGRectMake(1337, 42, 100, 100)));
}

@end
