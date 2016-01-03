#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCInstanceVariableMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSDictionary *instanceVariables;

@end


@implementation OCInstanceVariableMirrorTests

- (void)setUp {
	[super setUp];
	self.instanceVariables = [reflect([OCInstanceVariableClass class]) instanceVariables];
}

- (void)testInstanceVariableCount {
	XCTAssertEqual([self.instanceVariables count], 4);
}

- (void)testInstanceVariableName {
	OCInstanceVariableMirror *mirror = [self.instanceVariables objectForKey:@"publicIvar"];
	XCTAssertNotNil(mirror);
	XCTAssertEqualObjects(mirror.name, @"publicIvar");
}

- (void)testPrivateInstanceVariables {
	OCInstanceVariableMirror *mirror = [self.instanceVariables objectForKey:@"privateIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testAutoSynthesizedInstanceVariable {
	OCInstanceVariableMirror *mirror = [self.instanceVariables objectForKey:@"_propertyWithIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testReadonlyProperty {
	OCInstanceVariableMirror *mirror = [self.instanceVariables objectForKey:@"_propertyWithoutIvar"];
	XCTAssertNil(mirror);
}

- (void)testSynthesizedInstanceVariable {
	OCInstanceVariableMirror *mirror1 = [self.instanceVariables objectForKey:@"_propertyWithSynthesizedIvarBaz"];
	XCTAssertNotNil(mirror1);
	OCInstanceVariableMirror *mirror2 = [self.instanceVariables objectForKey:@"_propertyWithSynthesizedIvar"];
	XCTAssertNil(mirror2);
}

- (void)testInstanceVariableType {
	OCInstanceVariableMirror *mirror = [self.instanceVariables objectForKey:@"privateIvar"];
	XCTAssertEqual([[mirror type] class], [OCCharTypeMirror class]);
}

@end
