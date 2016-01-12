#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGProtocolMirrorTests : XCTestCase

@end


@implementation HGProtocolMirrorTests

- (void)testInitFromReflect {
	HGProtocolMirror *mirror = reflect(@protocol(NSObject));
	XCTAssertNotNil(mirror);
	XCTAssertEqualObjects([mirror mirroredProtocol], @protocol(NSObject));
}

- (void)testAdoptedProtocols {
	HGProtocolMirror *mirror = reflect(@protocol(NSSecureCoding));
	NSArray *adoptedProtocols = [mirror adoptedProtocols];
	XCTAssertEqual([adoptedProtocols count], 1);
	XCTAssertEqualObjects([[adoptedProtocols firstObject] mirroredProtocol], @protocol(NSCoding));
}

- (void)testNoAdoptedProtocols {
	HGProtocolMirror *mirror = reflect(@protocol(NSCoding));
	NSArray *adoptedProtocols = [mirror adoptedProtocols];
	XCTAssertEqual([adoptedProtocols count], 0);
}

- (void)testAllProtocols {
	NSArray *allProtocols = [HGProtocolMirror allProtocols];
	XCTAssertGreaterThan([allProtocols count], 1);
	XCTAssertEqual([[allProtocols firstObject] class], [HGProtocolMirror class]);
}

- (void)testName {
	HGProtocolMirror *mirror = reflect(@protocol(NSSecureCoding));
	XCTAssertEqualObjects([mirror name], @"NSSecureCoding");
}

- (void)testInstanceMethodNamed {
	HGProtocolMirror *mirror = reflect(@protocol(NSCoding));
	HGMethodDescriptionMirror *method = [mirror instanceMethodNamed:@selector(initWithCoder:)];
	XCTAssertNotNil(method);
	XCTAssertEqual([method selector], @selector(initWithCoder:));
}

- (void)testInstanceMethodNamedMissing {
	HGProtocolMirror *mirror = reflect(@protocol(NSCoding));
	HGMethodDescriptionMirror *method = [mirror instanceMethodNamed:@selector(value:withObjCType:)];
	XCTAssertNil(method);
}

- (void)testInstanceMethods {
	HGProtocolMirror *mirror = reflect(@protocol(HGTestProtocol));
	NSArray *methods = [mirror instanceMethods];
	XCTAssertEqual([methods count], 2);
	HGMethodDescriptionMirror *m1 = [methods firstObject];
	XCTAssertTrue(m1.isInstanceMethod);
	XCTAssertFalse(m1.isClassMethod);
	XCTAssertTrue(m1.isRequired);
	XCTAssertFalse(m1.isOptional);
	HGMethodDescriptionMirror *m2 = [methods lastObject];
	XCTAssertTrue(m2.isInstanceMethod);
	XCTAssertFalse(m2.isClassMethod);
	XCTAssertTrue(m2.isOptional);
	XCTAssertFalse(m2.isRequired);
}

- (void)testClassMethodNamed {
	HGProtocolMirror *mirror = reflect(@protocol(HGTestProtocol));
	HGMethodDescriptionMirror *method = [mirror classMethodNamed:@selector(requiredClassMethodWithArgument:)];
	XCTAssertNotNil(method);
	XCTAssertEqual([method selector], @selector(requiredClassMethodWithArgument:));
}

- (void)testClassMethodNamedMissing {
	HGProtocolMirror *mirror = reflect(@protocol(NSCoding));
	HGMethodDescriptionMirror *method = [mirror classMethodNamed:@selector(value:withObjCType:)];
	XCTAssertNil(method);
}

- (void)testClassMethods {
	HGProtocolMirror *mirror = reflect(@protocol(HGTestProtocol));
	NSArray *methods = [mirror classMethods];
	XCTAssertEqual([methods count], 2);
	HGMethodDescriptionMirror *m1 = [methods firstObject];
	XCTAssertTrue(m1.isClassMethod);
	XCTAssertFalse(m1.isInstanceMethod);
	XCTAssertTrue(m1.isRequired);
	XCTAssertFalse(m1.isOptional);
	HGMethodDescriptionMirror *m2 = [methods lastObject];
	XCTAssertTrue(m2.isClassMethod);
	XCTAssertFalse(m2.isInstanceMethod);
	XCTAssertTrue(m2.isOptional);
	XCTAssertFalse(m2.isRequired);
}

- (void)testAddProtocol {
	HGProtocolMirror *mirror = [HGProtocolMirror addProtocolNamed:@"HGTestProtocol123"];
	XCTAssertNotNil(mirror);
	[mirror registerProtocol];
	XCTAssertEqual(mirror.mirroredProtocol, NSProtocolFromString(@"HGTestProtocol123"));
}

- (void)testAdoptProtocol {
	HGProtocolMirror *mirror = [HGProtocolMirror addProtocolNamed:@"HGTestProtocol123baz"];
	XCTAssertNotNil(mirror);
	[mirror adoptProtocol:@protocol(NSCopying)];
	NSArray *adoptedProtocols = [mirror adoptedProtocols];
	XCTAssertEqual([adoptedProtocols count], 1);
	HGProtocolMirror *protocol = [adoptedProtocols firstObject];
	XCTAssertEqualObjects([protocol name], @"NSCopying");
}

- (void)testAdoptAdoptedProtocol {
	HGProtocolMirror *mirror = [HGProtocolMirror addProtocolNamed:@"HGTestProtocol1234"];
	XCTAssertNotNil(mirror);
	HGProtocolMirror *m1 = [mirror adoptProtocol:@protocol(NSCopying)];
	HGProtocolMirror *m2 = [mirror adoptProtocol:@protocol(NSCopying)];
	XCTAssertNotNil(m1);
	XCTAssertNil(m2);
}

- (void)testAdoptOnRegisteredProtocol {
	HGProtocolMirror *mirror = reflect(@protocol(NSObject));
	HGProtocolMirror *protocol = [mirror adoptProtocol:@protocol(NSSecureCoding)];
	XCTAssertNil(protocol);
}

- (void)testAddProtocolFailure {
	HGProtocolMirror *mirror = [HGProtocolMirror addProtocolNamed:@"NSObject"];
	XCTAssertNil(mirror);
}

- (void)testProperties {
	HGProtocolMirror *mirror = reflect(@protocol(HGPropertyTestProtocol));
	NSArray *properties = [mirror properties];
	XCTAssertEqual([properties count], 1);
	HGPropertyMirror *property = [properties firstObject];
	XCTAssertTrue([property isNonatomic]);
	XCTAssertFalse([property isReadonly]);
	XCTAssertEqualObjects(property.name, @"property1");
}

- (void)testIsEqual {
	HGProtocolMirror *m1 = reflect(@protocol(NSSecureCoding));
	HGProtocolMirror *m2 = reflect(@protocol(NSSecureCoding));
	HGProtocolMirror *m3 = reflect(@protocol(NSObject));
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
}

- (void)testHash {
	NSDictionary *test = @{
		reflect(@protocol(NSSecureCoding)) : @1,
		reflect(@protocol(NSSecureCoding)) : @2,
		reflect(@protocol(NSObject)) : @3,
		[NSValue valueWithNonretainedObject:@protocol(NSObject)] : @4
	};
	XCTAssertEqual([test count], 3);
	XCTAssertEqualObjects([test objectForKey:[NSValue valueWithNonretainedObject:@protocol(NSObject)]], @4);
}

@end
