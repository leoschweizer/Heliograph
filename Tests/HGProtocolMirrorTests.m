#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>


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

@end
