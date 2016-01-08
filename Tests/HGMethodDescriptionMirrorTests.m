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

@end
