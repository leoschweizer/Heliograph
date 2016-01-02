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

- (void)testProperty1 {
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property1"];
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
	OCPropertyMirror *mirror = [self.properties objectForKey:@"property2"];
	XCTAssertNotNil(mirror);
	XCTAssertFalse([mirror isReadonly]);
	XCTAssertFalse([mirror isCopied]);
	XCTAssertFalse([mirror isNonatomic]);
	XCTAssertFalse([mirror isGarbageCollected]);
	XCTAssertFalse([mirror isDynamic]);
	XCTAssertTrue([mirror isWeak]);
	XCTAssertFalse([mirror isRetained]);
}

@end
