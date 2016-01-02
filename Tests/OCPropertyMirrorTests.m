#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCPropertyMirrorTests : XCTestCase

@end


@implementation OCPropertyMirrorTests

- (void)testName {
	NSDictionary *properties = [reflect([OCPropertyClass class]) properties];
	OCPropertyMirror *mirror = [properties objectForKey:@"property1"];
	XCTAssertEqualObjects([mirror name], @"property1");
}

- (void)testReadonlyProperty {
	NSDictionary *properties = [reflect([OCPropertyClass class]) properties];
	OCPropertyMirror *mirror = [properties objectForKey:@"property1"];
	XCTAssertNotNil(mirror);
	XCTAssertTrue([mirror isReadonly]);
}

@end
