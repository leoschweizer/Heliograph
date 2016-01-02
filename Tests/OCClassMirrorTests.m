#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCClassMirrorsTests : XCTestCase

@end


@implementation OCClassMirrorsTests

- (void)testInit {
	Class testClass = [NSString class];
	OCClassMirror *classMirror = [[OCClassMirror alloc] initWithClass:testClass];
	XCTAssertEqual(classMirror.mirroredClass, testClass);
}

- (void)testInitFromReflect {
	OCClassMirror *classMirror = reflect([NSNumber class]);
	XCTAssertEqual(classMirror.mirroredClass, [NSNumber class]);
}

- (void)testAllSubclasses {
	OCClassMirror *classMirror = reflect([OCRootClass class]);
	NSArray *allSubclasses = [classMirror allSubclasses];
	for (OCClassMirror *classMirror in allSubclasses) {
		NSLog(@"%@", classMirror.name);
	}
	XCTAssertEqual([allSubclasses count], 4);
}

@end
