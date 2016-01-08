#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>


@protocol HGTestProtocol

@required
- (void)requiredInstanceMethod;
+ (id)requiredClassMethodWithArgument:(BOOL)arg;

@optional
- (NSString *)optionalInstanceMethod;
+ (id<NSSecureCoding>)optionalClassMethod:(NSUInteger)arg;

@end


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

@end
