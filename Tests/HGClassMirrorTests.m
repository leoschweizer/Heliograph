#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGClassMirrorsTests : XCTestCase

@end


@implementation HGClassMirrorsTests

- (void)testInit {
	Class testClass = [NSString class];
	HGClassMirror *classMirror = [[HGClassMirror alloc] initWithClass:testClass];
	XCTAssertEqual(classMirror.mirroredClass, testClass);
}

- (void)testInitFromReflect {
	HGClassMirror *classMirror = reflect([NSNumber class]);
	XCTAssertEqual(classMirror.mirroredClass, [NSNumber class]);
}

- (void)testAllSubclasses {
	HGClassMirror *classMirror = reflect([HGRootClass class]);
	NSArray *allSubclasses = [classMirror allSubclasses];
	XCTAssertEqual([allSubclasses count], 4);
}

- (void)testMetaclassMirror {
	HGClassMirror *mirror = reflect([HGDescendant2 class]);
	XCTAssertFalse([mirror isMetaclass]);
	HGClassMirror *metaMirror = [mirror classMirror];
	XCTAssertTrue([metaMirror isMetaclass]);
}

- (void)testMethods {
	HGClassMirror *mirror1 = reflect([HGDescendant1 class]);
	NSArray *methods1 = [mirror1 methods];
	HGClassMirror *mirror2 = reflect([HGDescendant1Descendant1 class]);
	NSArray *methods2 = [mirror2 methods];
	XCTAssertEqual([methods1 count], 1);
	XCTAssertEqual([[methods1 firstObject] selector], @selector(methodDefinedInDescendant1));
	XCTAssertEqual([methods2 count], 1);
	XCTAssertEqual([[methods2 firstObject] selector], @selector(methodDefinedInDescendant1Descendant1));
}

- (void)testMetaclassMethods {
	HGClassMirror *mirror = reflect([HGDescendant1Descendant1 class]);
	HGClassMirror *metaMirror = [mirror classMirror];
	NSArray *methods = [metaMirror methods];
	XCTAssertEqual([methods count], 1);
	XCTAssertEqual([[methods firstObject] selector], @selector(classMethodDefinedInDescendant1Descendant1));
}

- (void)testDescription {
	NSString *description = [NSString stringWithFormat:@"%@", reflect([NSString class])];
	XCTAssertEqualObjects(description, @"<HGClassMirror on NSString>");
	NSString *metaDescription = [NSString stringWithFormat:@"%@", [reflect([NSString class]) classMirror]];
	XCTAssertEqualObjects(metaDescription, @"<HGClassMirror on NSString class>");
}

- (void)testSubclasses {
	HGClassMirror *classMirror = reflect([HGRootClass class]);
	NSArray *subclasses = [classMirror subclasses];
	XCTAssertEqual([subclasses count], 2);
}

- (void)testSuperclass {
	HGClassMirror *mirror = reflect([NSValue class]);
	XCTAssertEqual([[mirror superclass] mirroredClass], [NSObject class]);
}

- (void)testSuperclassMissing {
	HGClassMirror *mirror = reflect([NSObject class]);
	XCTAssertNil([mirror superclass]);
}

- (void)testAdoptedProtocols {
	HGClassMirror *mirror = reflect([NSObject class]);
	NSArray *adoptedProtocols = [mirror adoptedProtocols];
	XCTAssertEqual([adoptedProtocols count], 1);
	XCTAssertEqualObjects([[adoptedProtocols firstObject] mirroredProtocol], @protocol(NSObject));
}

- (void)testAllClasses {
	NSArray *allClasses = [HGClassMirror allClasses];
	XCTAssertGreaterThan([allClasses count], 1);
	XCTAssertEqual([[allClasses firstObject] class], [HGClassMirror class]);
}

- (void)testGetMissingMethod {
	HGMethodMirror *mirror = [reflect([HGRootClass class]) methodWithSelector:@selector(methodDefinedInDescendant1)];
	XCTAssertNil(mirror);
}

- (void)testGetClassMethod {
	HGClassMirror *metaMirror = [reflect([HGDescendant1Descendant1 class]) classMirror];
	HGMethodMirror *methodMirror = [metaMirror methodWithSelector:@selector(classMethodDefinedInDescendant1Descendant1)];
	XCTAssertNotNil(methodMirror);
}

- (void)testGetMethodFromSuperclass {
	HGMethodMirror *mirror = [reflect([HGDescendant1Descendant2 class]) methodWithSelector:@selector(methodDefinedInDescendant1)];
	XCTAssertNotNil(mirror);
	XCTAssertEqual([[mirror definingClass] mirroredClass], [HGDescendant1 class]);
}

@end
