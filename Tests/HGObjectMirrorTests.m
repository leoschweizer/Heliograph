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
	NSArray *classMethods = [mirror classMethods];
	XCTAssertEqual([classMethods count], 1);
	XCTAssertEqual([[classMethods firstObject] selector], @selector(classMethodDefinedInDescendant1Descendant1));
}

- (void)testClassMirror {
	HGObjectMirror *mirror = reflect(@"Dr. Pepper");
	XCTAssertTrue([[[mirror classMirror] mirroredClass] isSubclassOfClass:[NSString class]]);
	XCTAssertEqualObjects([mirror classMirror], [mirror type]);
}

- (void)testInstanceMethods {
	HGObjectMirror *mirror = reflect([HGDescendant1Descendant1 new]);
	NSArray *instanceMethods = [mirror instanceMethods];
	XCTAssertEqual([instanceMethods count], 1);
	XCTAssertEqual([[instanceMethods firstObject] selector], @selector(methodDefinedInDescendant1Descendant1));
}

@end
