#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGMethodDescriptionMirrorTests : XCTestCase

@end


@implementation HGMethodDescriptionMirrorTests

- (void)testNumberOfArguments {
	HGMethodDescriptionMirror *mirror1 = [[reflect(@protocol(HGTestProtocol)) instanceMethods] firstObject];
	XCTAssertEqual([mirror1 numberOfArguments], 0);
	HGMethodDescriptionMirror *mirror2 = [[reflect(@protocol(HGTestProtocol)) classMethods] firstObject];
	XCTAssertEqual([mirror2 numberOfArguments], 1);
}

- (void)testSelector {
	HGMethodDescriptionMirror *mirror = [[reflect(@protocol(HGTestProtocol)) instanceMethods] firstObject];
	XCTAssertEqual([mirror selector], @selector(requiredInstanceMethod));
}

- (void)testIsEqual {
	HGMethodDescriptionMirror *m1 = [reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(encodeWithCoder:)];
	HGMethodDescriptionMirror *m2 = [reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(encodeWithCoder:)];
	HGMethodDescriptionMirror *m3 = [reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(initWithCoder:)];
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
}

- (void)testHash {
	NSDictionary *test = @{
		[reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(encodeWithCoder:)] : @1,
		[reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(encodeWithCoder:)] : @2,
		[reflect(@protocol(NSCoding)) instanceMethodNamed:@selector(initWithCoder:)] : @3
	};
	XCTAssertEqual([test count], 2);
}

@end
