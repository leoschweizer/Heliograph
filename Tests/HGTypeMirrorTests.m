#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGTypeMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSDictionary *properties;

@end


@implementation HGTypeMirrorTests

- (void)setUp {
	[super setUp];
	self.properties = [reflect([HGTypeTestClass class]) properties];
}

- (void)testObjectType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"stringProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGObjectTypeMirror class]);
	XCTAssertEqual([[typeMirror classMirror] mirroredClass], [NSString class]);
}

- (void)testIdType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"idProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGObjectTypeMirror class]);
	XCTAssertNil([typeMirror classMirror]);
}

- (void)testClassType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"classProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGClassTypeMirror class]);
}

- (void)testCharType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"charProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGCharTypeMirror class]);
}

- (void)testIntType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"intProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGIntTypeMirror class]);
}

- (void)testBoolType {
	HGPropertyMirror *mirror = [self.properties objectForKey:@"boolProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGBoolTypeMirror class]);
}

@end
