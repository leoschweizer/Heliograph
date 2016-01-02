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

- (void)testMetaclassMirror {
	OCClassMirror *mirror = reflect([OCDescendant2 class]);
	XCTAssertFalse([mirror isMetaclass]);
	OCClassMirror *metaMirror = [mirror classMirror];
	XCTAssertTrue([metaMirror isMetaclass]);
}

- (void)testMethods {
	OCClassMirror *mirror1 = reflect([OCDescendant1 class]);
	NSDictionary *methods1 = mirror1.methodDictionary;
	OCClassMirror *mirror2 = reflect([OCDescendant1Descendant1 class]);
	NSDictionary *methods2 = mirror2.methodDictionary;
	XCTAssertEqual([methods1 count], 1);
	XCTAssertNotNil([methods1 objectForKey:@"methodDefinedInDescendant1"]);
	XCTAssertEqual([methods2 count], 1);
	XCTAssertNotNil([methods2 objectForKey:@"methodDefinedInDescendant1Descendant1"]);
}

- (void)testMetaclassMethods {
	OCClassMirror *mirror = reflect([OCDescendant1Descendant1 class]);
	OCClassMirror *metaMirror = [mirror classMirror];
	NSDictionary *methodDictionary = metaMirror.methodDictionary;
	XCTAssertEqual([methodDictionary count], 1);
	XCTAssertNotNil([methodDictionary objectForKey:@"classMethodDefinedInDescendant1Descendant1"]);
}

- (void)testDescription {
	NSString *description = [NSString stringWithFormat:@"%@", reflect([NSString class])];
	XCTAssertEqualObjects(description, @"<OCClassMirror on NSString>");
	NSString *metaDescription = [NSString stringWithFormat:@"%@", [reflect([NSString class]) classMirror]];
	XCTAssertEqualObjects(metaDescription, @"<OCClassMirror on NSString class>");
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
