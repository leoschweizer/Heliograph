#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCTypeMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSDictionary *properties;

@end


@implementation OCTypeMirrorTests

- (void)setUp {
	[super setUp];
	self.properties = [reflect([OCTypeTestClass class]) properties];
}

- (void)testObjectType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"stringProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCObjectTypeMirror class]);
	XCTAssertEqual([[typeMirror classMirror] mirroredClass], [NSString class]);
}

- (void)testIdType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"idProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCObjectTypeMirror class]);
	XCTAssertNil([typeMirror classMirror]);
}

- (void)testClassType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"classProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCClassTypeMirror class]);
}

- (void)testCharType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"charProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCCharTypeMirror class]);
}

- (void)testIntType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"intProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCIntTypeMirror class]);
}

- (void)testBoolType {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"boolProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [OCBoolTypeMirror class]);
}

@end
