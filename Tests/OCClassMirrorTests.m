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
	XCTAssertEqual([allSubclasses count], 4);
}

- (void)testDescription {
	NSString *description = [NSString stringWithFormat:@"%@", reflect([NSString class])];
	XCTAssertEqualObjects(description, @"<OCClassMirror on NSString>");
}

- (void)testSubclasses {
	OCClassMirror *classMirror = reflect([OCRootClass class]);
	NSArray *subclasses = [classMirror subclasses];
	XCTAssertEqual([subclasses count], 2);
}

- (void)testSuperclass {
	OCClassMirror *mirror = reflect([NSValue class]);
	XCTAssertEqual([[mirror superclass] mirroredClass], [NSObject class]);
}

- (void)testSuperclassMissing {
	OCClassMirror *mirror = reflect([NSObject class]);
	XCTAssertNil([mirror superclass]);
}

@end
