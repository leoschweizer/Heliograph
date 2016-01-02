#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>
#import "OCTestHierarchy.h"


@interface OCObjectMirrorTests : XCTestCase

@end


@implementation OCObjectMirrorTests

- (void)testInit {
	OCObjectMirror *mirror = [[OCObjectMirror alloc] initWithObject:@42];
	XCTAssertEqualObjects(mirror.mirroredObject, @42);
}

- (void)testInitFromReflect {
	OCObjectMirror *mirror = reflect([NSNumber numberWithInteger:1337]);
	XCTAssertEqualObjects(mirror.mirroredObject, @1337);
}

- (void)testClassMethods {
	OCObjectMirror *mirror = reflect([OCDescendant1Descendant1 new]);
	NSDictionary *classMethods = [mirror classMethods];
	XCTAssertEqual([classMethods count], 1);
	XCTAssertNotNil([classMethods objectForKey:@"classMethodDefinedInDescendant1Descendant1"]);
}

- (void)testClassMirror {
	OCObjectMirror *mirror = reflect(@"Dr. Pepper");
	XCTAssertTrue([[[mirror classMirror] mirroredClass] isSubclassOfClass:[NSString class]]);
}

- (void)testInstanceMethods {
	OCObjectMirror *mirror = reflect([OCDescendant1Descendant1 new]);
	NSDictionary *instanceMethods = [mirror instanceMethods];
	XCTAssertEqual([instanceMethods count], 1);
	XCTAssertNotNil([instanceMethods objectForKey:@"methodDefinedInDescendant1Descendant1"]);
}

@end
