#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGObjectMirrorTests : XCTestCase

@end


@implementation HGObjectMirrorTests

- (void)testInit {
	HGObjectMirror *mirror = [[HGObjectMirror alloc] initWithObject:@42];
	XCTAssertEqualObjects(mirror.mirroredObject, @42);
}

- (void)testInitFromReflect {
	HGObjectMirror *mirror = reflect([NSNumber numberWithInteger:1337]);
	XCTAssertEqualObjects(mirror.mirroredObject, @1337);
}

- (void)testClassMethods {
	HGObjectMirror *mirror = reflect([HGDescendant1Descendant1 new]);
	NSDictionary *classMethods = [mirror classMethods];
	XCTAssertEqual([classMethods count], 1);
	XCTAssertNotNil([classMethods objectForKey:@"classMethodDefinedInDescendant1Descendant1"]);
}

- (void)testClassMirror {
	HGObjectMirror *mirror = reflect(@"Dr. Pepper");
	XCTAssertTrue([[[mirror classMirror] mirroredClass] isSubclassOfClass:[NSString class]]);
}

- (void)testInstanceMethods {
	HGObjectMirror *mirror = reflect([HGDescendant1Descendant1 new]);
	NSDictionary *instanceMethods = [mirror instanceMethods];
	XCTAssertEqual([instanceMethods count], 1);
	XCTAssertNotNil([instanceMethods objectForKey:@"methodDefinedInDescendant1Descendant1"]);
}

@end
