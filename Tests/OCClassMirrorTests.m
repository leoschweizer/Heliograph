#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>


@interface OCClassMirrorsTests : XCTestCase

@end


@implementation OCClassMirrorsTests

- (void)testInit {
	Class testClass = [NSString class];
	OCClassMirror *classMirror = [[OCClassMirror alloc] initWithClass:testClass];
	XCTAssertEqual(classMirror.mirroredClass, testClass);
}

@end
