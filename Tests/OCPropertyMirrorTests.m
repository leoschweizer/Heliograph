#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCPropertyMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSDictionary *properties;

@end


@implementation OCPropertyMirrorTests

- (void)setUp {
	self.properties = [reflect([OCPropertyClass class]) properties];
}

- (void)testName {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	XCTAssertEqualObjects([mirror name], @"property1");
}

- (void)testReadonlyProperty {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	XCTAssertNotNil(mirror);
	XCTAssertTrue([mirror isReadonly]);
}

- (void)testCopiedProperty {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
	XCTAssertNotNil(mirror);
	XCTAssertTrue([mirror isCopied]);
}

- (void)testReadwriteProperty {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property2"];
	XCTAssertNotNil(mirror);
	XCTAssertFalse([mirror isReadonly]);
}

- (void)testNoncopiedProperty {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property2"];
	XCTAssertNotNil(mirror);
	XCTAssertFalse([mirror isCopied]);
}

@end
