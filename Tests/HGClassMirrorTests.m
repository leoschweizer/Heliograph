#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"
#import <objc/runtime.h>


@interface HGClassMirrorsTests : XCTestCase

@end


@implementation HGClassMirrorsTests

- (void)testInit {
	Class testClass = [NSString class];
	HGClassMirror *classMirror = [[HGClassMirror alloc] initWithClass:testClass];
	XCTAssertEqual(HGClassFromClassMirror(classMirror), testClass);
}

- (void)testInitFromReflect {
	HGClassMirror *classMirror = reflect([NSNumber class]);
	XCTAssertEqual(HGClassFromClassMirror(classMirror), [NSNumber class]);
}

- (void)testNonNSObjectClass {
	Class class = objc_getClass("__NSMessageBuilder");
	HGClassMirror *mirror = [[HGClassMirror alloc] initWithClass:class];
	XCTAssertEqual(HGClassFromClassMirror(mirror), class);
}

- (void)testAllSubclasses {
	HGClassMirror *classMirror = reflect([HGRootClass class]);
	NSArray *allSubclasses = [classMirror allSubclasses];
	XCTAssertEqual([allSubclasses count], 4);
}

- (void)testAllSuperclasses {
	NSArray *superclasses = [reflect([NSMutableString class]) allSuperclasses];
	XCTAssertNotNil(superclasses);
	XCTAssertEqual([superclasses count], 2);
	XCTAssertEqualObjects([superclasses firstObject], reflect([NSString class]));
	XCTAssertEqualObjects([superclasses lastObject], reflect([NSObject class]));
}

- (void)testAllSuperclassesEmpty {
	NSArray *superclasses = [reflect([NSObject class]) allSuperclasses];
	XCTAssertNotNil(superclasses);
	XCTAssertEqual([superclasses count], 0);
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

- (void)testProperties {
	HGClassMirror *classMirror = reflect([HGPropertyClass class]);
	NSArray *properties = [classMirror properties];
	XCTAssertGreaterThan([properties count], 1);
}

- (void)testSubclasses {
	HGClassMirror *classMirror = reflect([HGRootClass class]);
	NSArray *subclasses = [classMirror subclasses];
	XCTAssertEqual([subclasses count], 2);
}

- (void)testSuperclass {
	HGClassMirror *mirror = reflect([NSValue class]);
	XCTAssertEqual(HGClassFromClassMirror([mirror superclass]), [NSObject class]);
}

- (void)testSuperclassMissing {
	HGClassMirror *mirror = reflect([NSObject class]);
	XCTAssertNil([mirror superclass]);
}

- (void)testAddInstanceVariable {
	HGClassMirror *superclass = reflect([NSObject class]);
	HGClassMirror *class = [superclass addSubclassNamed:@"HGFooBarBazIvarTest"];
	HGInstanceVariableMirror *mirror = [class addInstanceVariableNamed:@"_testIvar" withEncoding:@encode(BOOL)];
	[class registerClass];
	XCTAssertNotNil(mirror);
	XCTAssertEqualObjects(mirror.name, @"_testIvar");
}

- (void)testAddExistingInstanceVariable {
	HGClassMirror *superclass = reflect([NSObject class]);
	HGClassMirror *class = [superclass addSubclassNamed:@"HGFooBarBazIvarTest2"];
	HGInstanceVariableMirror *mirror1 = [class addInstanceVariableNamed:@"_testIvar" withEncoding:@encode(BOOL)];
	HGInstanceVariableMirror *mirror2 = [class addInstanceVariableNamed:@"_testIvar" withEncoding:@encode(BOOL)];
	[class registerClass];
	XCTAssertNotNil(mirror1);
	XCTAssertNil(mirror2);
}

- (void)testAddSubclass {
	HGClassMirror *superclass = reflect([NSObject class]);
	HGClassMirror *subclass = [superclass addSubclassNamed:@"HGThisIsATestSubclass"];
	XCTAssertNotNil(subclass);
	XCTAssertEqualObjects([subclass name], @"HGThisIsATestSubclass");
}

- (void)testAddSubclassFailure {
	HGClassMirror *superclass = reflect([NSObject class]);
	HGClassMirror *subclass = [superclass addSubclassNamed:@"NSObject"];
	XCTAssertNil(subclass);
}

NSUInteger hg_fake_hash(id self, SEL cmd) {
	return 1337;
}

- (void)testAddMethod {
	HGClassMirror *superclass = reflect([NSObject class]);
	HGClassMirror *class = [superclass addSubclassNamed:@"HGFooBarBaz"];
	HGMethodMirror *originalHash = [superclass methodNamed:@selector(hash)];
	HGMethodMirror *overriddenHash = [class addMethodNamed:@selector(hash) withImplementation:(IMP)hg_fake_hash andEncoding:originalHash.encoding];
	XCTAssertNotNil(overriddenHash);
	XCTAssertEqual([overriddenHash selector], @selector(hash));
	id instance = [[HGClassFromClassMirror(class) alloc] init];
	XCTAssertEqual([instance hash], 1337);
}

- (void)testAddMethodWithExistingSelector {
	HGClassMirror *mirror = reflect([NSObject class]);
	HGMethodMirror *existing = [mirror methodNamed:@selector(hash)];
	HGMethodMirror *method = [mirror addMethodNamed:@selector(hash) withImplementation:existing.implementation andEncoding:existing.encoding];
	XCTAssertNil(method);
}

- (void)testAdoptedProtocols {
	HGClassMirror *mirror = reflect([NSObject class]);
	NSArray *adoptedProtocols = [mirror adoptedProtocols];
	XCTAssertEqual([adoptedProtocols count], 1);
	XCTAssertEqualObjects([[adoptedProtocols firstObject] mirroredProtocol], @protocol(NSObject));
}

- (void)testAdoptProtocol {
	HGClassMirror *mirror = reflect([NSObject class]);
	HGClassMirror *subclass = [mirror addSubclassNamed:@"HGProtocolAdoptionTest"];
	[subclass registerClass];
	HGProtocolMirror *protocol = [subclass adoptProtocol:@protocol(HGTestProtocol)];
	XCTAssertNotNil(protocol);
	XCTAssertTrue([NSClassFromString(@"HGProtocolAdoptionTest") conformsToProtocol:@protocol(HGTestProtocol)]);
}

- (void)testAdoptProtocolFailure {
	HGClassMirror *mirror = reflect([NSObject class]);
	HGProtocolMirror *protocol = [mirror adoptProtocol:@protocol(NSObject)];
	XCTAssertNil(protocol);
}

- (void)testAllClasses {
	NSArray *allClasses = [HGClassMirror allClasses];
	XCTAssertGreaterThan([allClasses count], 1);
	XCTAssertEqual([[allClasses firstObject] class], [HGClassMirror class]);
	for (HGClassMirror *each in allClasses) {
		XCTAssertNotNil([each name]);
	}
}

- (void)testGetMissingMethod {
	HGMethodMirror *mirror = [reflect([HGRootClass class]) methodNamed:@selector(methodDefinedInDescendant1)];
	XCTAssertNil(mirror);
}

- (void)testGetClassMethod {
	HGClassMirror *metaMirror = [reflect([HGDescendant1Descendant1 class]) classMirror];
	HGMethodMirror *methodMirror = [metaMirror methodNamed:@selector(classMethodDefinedInDescendant1Descendant1)];
	XCTAssertNotNil(methodMirror);
}

- (void)testGetMethodFromSuperclass {
	HGMethodMirror *mirror = [reflect([HGDescendant1Descendant2 class]) methodNamed:@selector(methodDefinedInDescendant1)];
	XCTAssertNotNil(mirror);
	XCTAssertEqual(HGClassFromClassMirror([mirror definingClass]), [HGDescendant1 class]);
}

- (void)testIsEqual {
	HGClassMirror *m1 = reflect([NSString class]);
	HGClassMirror *m2 = reflect([NSString class]);
	HGClassMirror *m3 = reflect([NSMutableString class]);
	HGClassMirror *m4 = [m1 classMirror];
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m4, m1);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
}

- (void)testHash {
	NSDictionary *test = @{
		reflect([NSObject class]) : @1,
		reflect([NSObject class]) : @2,
		reflect([NSMutableString class]) : @3,
		[NSValue valueWithNonretainedObject:[NSString class]] : @4
	};
	XCTAssertEqual([test count], 3);
	XCTAssertEqualObjects([test objectForKey:[NSValue valueWithNonretainedObject:[NSString class]]], @4);
}

- (void)testSiblings {
	HGClassMirror *mirror = reflect([HGDescendant1 class]);
	NSArray *siblings = [mirror siblings];
	XCTAssertNotNil(siblings);
	XCTAssertEqual([siblings count], 1);
	XCTAssertEqualObjects([siblings firstObject], reflect([HGDescendant2 class]));
}

- (void)testSiblingsWithoutSuperclass {
	HGClassMirror *mirror = reflect([NSObject class]);
	NSArray *siblings = [mirror siblings];
	XCTAssertNotNil(siblings);
	XCTAssertEqual([siblings count], 0);
}

@end
