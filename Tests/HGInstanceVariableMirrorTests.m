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
	XCTAssertEqual([self.instanceVariables count], 4);
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

@end
