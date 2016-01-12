#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>


@interface HGValueMirrorTests : XCTestCase

@end


@implementation HGValueMirrorTests

- (void)testObjectDescription {
	id value = @44;
	id<HGValueMirror> mirror = [[HGObjectMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(id)]];
	XCTAssertEqualObjects([mirror valueDescription], [value description]);
}

- (void)testClassDescription {
	id<HGValueMirror> mirror = reflect([NSMutableSet class]);
	XCTAssertEqualObjects([mirror valueDescription], @"NSMutableSet");
}

- (void)testCharDescription {
	char value = -8;
	id<HGValueMirror> mirror = [[HGCharValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(char)]];
	XCTAssertEqualObjects([mirror valueDescription], @"-8");
}

- (void)testShortDescription {
	short value = -16;
	id<HGValueMirror> mirror = [[HGShortValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(short)]];
	XCTAssertEqualObjects([mirror valueDescription], @"-16");
}

- (void)testIntDescription {
	int value = -32;
	id<HGValueMirror> mirror = [[HGIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(int)]];
	XCTAssertEqualObjects([mirror valueDescription], @"-32");
}

- (void)testLongDescription {
	long value = -64;
	id<HGValueMirror> mirror = [[HGLongValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(long)]];
	XCTAssertEqualObjects([mirror valueDescription], @"-64");
}

- (void)testLongLongDescription {
	long long value = -128;
	id<HGValueMirror> mirror = [[HGLongLongValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(long long)]];
	XCTAssertEqualObjects([mirror valueDescription], @"-128");
}

- (void)testUnsignedCharDescription {
	unsigned char value = 8;
	id<HGValueMirror> mirror = [[HGUnsignedCharValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(unsigned char)]];
	XCTAssertEqualObjects([mirror valueDescription], @"8");
}

- (void)testUnsignedShortDescription {
	unsigned short value = 16;
	id<HGValueMirror> mirror = [[HGUnsignedShortValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(unsigned short)]];
	XCTAssertEqualObjects([mirror valueDescription], @"16");
}

- (void)testUnsignedIntDescription {
	unsigned int value = 32;
	id<HGValueMirror> mirror = [[HGUnsignedIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(unsigned int)]];
	XCTAssertEqualObjects([mirror valueDescription], @"32");
}

- (void)testUnsignedLongDescription {
	unsigned long value = 64;
	id<HGValueMirror> mirror = [[HGUnsignedLongValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(unsigned long)]];
	XCTAssertEqualObjects([mirror valueDescription], @"64");
}

- (void)testUnsignedLongLongDescription {
	unsigned long long value = 128;
	id<HGValueMirror> mirror = [[HGUnsignedLongLongValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(unsigned long long)]];
	XCTAssertEqualObjects([mirror valueDescription], @"128");
}

- (void)testFloatDescription {
	float value = 3.14;
	id<HGValueMirror> mirror = [[HGFloatValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(float)]];
	XCTAssertEqualObjects([mirror valueDescription], @"3.14");
}

- (void)testDoubleDescription {
	double value = 1.33333;
	id<HGValueMirror> mirror = [[HGDoubleValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(double)]];
	XCTAssertEqualObjects([mirror valueDescription], @"1.33333");
}

- (void)testBoolDescription {
	_Bool value = true;
	id<HGValueMirror> mirror = [[HGBoolValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(_Bool)]];
	XCTAssertEqualObjects([mirror valueDescription], @"true");
}

- (void)testSelectorDescription {
	SEL value = @selector(predicateWithLeftExpression:rightExpression:modifier:type:options:);
	id<HGValueMirror> mirror = [[HGSelectorValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(SEL)]];
	XCTAssertEqualObjects([mirror valueDescription], @"predicateWithLeftExpression:rightExpression:modifier:type:options:");
}

- (void)testCharPointerDescription {
	char *value = "abcdefg";
	id<HGValueMirror> mirror = [[HGCharacterStringValueMirror alloc] initWithValue:[NSValue valueWithBytes:&value objCType:@encode(char *)]];
	XCTAssertEqualObjects([mirror valueDescription], @"abcdefg");
}

- (void)testArrayDescription {
	id<HGValueMirror> mirror = [[HGArrayValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"[array]");
}

- (void)testStructDescription {
	id<HGValueMirror> mirror = [[HGStructureValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"{struct}");
}

- (void)testUnionDescription {
	id<HGValueMirror> mirror = [[HGUnionValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"(union)");
}

- (void)testPointerDescription {
	id<HGValueMirror> mirror = [[HGPointerValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"<^>");
}

- (void)testBitFieldDescription {
	id<HGValueMirror> mirror = [[HGBitFieldValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"<bitfield>");
}

- (void)testUnknownDescription {
	id<HGValueMirror> mirror = [[HGUnknownValueMirror alloc] initWithValue:nil];
	XCTAssertEqualObjects([mirror valueDescription], @"<unknown>");
}

- (void)testIsEqual {
	int i = 5;
	SEL sel = @selector(didChangeValueForKey:);
	id<HGValueMirror> m1 = [[HGIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&i objCType:@encode(int)]];
	id<HGValueMirror> m2 = [[HGIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&i objCType:@encode(int)]];
	id<HGValueMirror> m3 = [[HGSelectorValueMirror alloc] initWithValue:[NSValue valueWithBytes:&sel objCType:@encode(SEL)]];
	id<HGValueMirror> m4 = reflect([NSString class]);
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m4, m1);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
	XCTAssertFalse([m4 isEqualToValueMirror:m1]);
}

- (void)testHash {
	int i = 5;
	SEL sel = @selector(didChangeValueForKey:);
	NSDictionary *test = @{
		[[HGIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&i objCType:@encode(int)]] : @1,
		[[HGIntValueMirror alloc] initWithValue:[NSValue valueWithBytes:&i objCType:@encode(int)]] : @2,
		[[HGSelectorValueMirror alloc] initWithValue:[NSValue valueWithBytes:&sel objCType:@encode(SEL)]] : @3,
		[NSValue valueWithBytes:&sel objCType:@encode(SEL)] : @4
	};
	XCTAssertEqual([test count], 3);
	XCTAssertEqualObjects([test objectForKey:[NSValue valueWithBytes:&sel objCType:@encode(SEL)]], @4);
}

@end
