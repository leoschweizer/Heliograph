#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGTypeMirrorTests : XCTestCase

@end


@implementation HGTypeMirrorTests

- (void)testBaseTypeAcceptsVisitor {
	HGBaseTypeMirror *mirror = [[HGBaseTypeMirror alloc] init];
	[mirror acceptTypeMirrorVisitor:nil];
}

- (void)testObjectType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"stringProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGObjectTypeMirror class]);
	XCTAssertEqual([[typeMirror classMirror] mirroredClass], [NSString class]);
	XCTAssertEqualObjects([typeMirror classMirror], [(HGObjectTypeMirror *)typeMirror type]);
}

- (void)testIdType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"idProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGObjectTypeMirror class]);
	XCTAssertNil([typeMirror classMirror]);
}

- (void)testClassType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"classProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGClassTypeMirror class]);
}

- (void)testCharType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"charProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGCharTypeMirror class]);
}

- (void)testIntType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"intProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGIntTypeMirror class]);
}

- (void)testBoolType {
	HGPropertyMirror *mirror = [reflect([HGTypeTestClass class]) propertyNamed:@"boolProperty"];
	XCTAssertNotNil(mirror);
	id typeMirror = [mirror type];
	XCTAssertEqual([typeMirror class], [HGBoolTypeMirror class]);
}

- (void)testTypeDescriptions {
	
	NSDictionary *definition = @{
		@"@" : @"id",
		@"#" : @"Class",
		@"c" : @"char",
		@"s" : @"short",
		@"i" : @"int",
		@"l" : @"long",
		@"q" : @"long long",
		@"C" : @"unsigned char",
		@"S" : @"unsigned short",
		@"I" : @"unsigned int",
		@"L" : @"unsigned long",
		@"Q" : @"unsigned long long",
		@"f" : @"float",
		@"d" : @"double",
		@"B" : @"bool",
		@"*" : @"char *",
		@":" : @"SEL",
		@"v" : @"void",
		@"[" : @"array",
		@"{" : @"struct",
		@"(" : @"union",
		@"b" : @"bitfield",
		@"^" : @"^",
		@"?" : @"unknown type",
		@"ö" : @"unknown type"
	};
	
	for (NSString *encoding in definition) {
		NSString *expectedOutput = [definition objectForKey:encoding];
		HGBaseTypeMirror *mirror = [HGBaseTypeMirror createForEncoding:encoding];
		NSString *typeDescription = [mirror typeDescription];
		XCTAssertEqualObjects(expectedOutput, typeDescription);
	}
	
	XCTAssertEqualObjects([reflect([NSString class]) typeDescription], @"NSString");
	XCTAssertEqualObjects([[reflect([NSString class]) classMirror] typeDescription], @"NSString class");
	
}

- (void)testIsEqual {
	id<HGTypeMirror> m1 = [HGBaseTypeMirror createForEncoding:@"q"];
	id<HGTypeMirror> m2 = [HGBaseTypeMirror createForEncoding:@"q"];
	id<HGTypeMirror> m3 = [HGBaseTypeMirror createForEncoding:@"@"];
	id<HGTypeMirror> m4 = reflect([NSString class]);
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m4, m1);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
	XCTAssertFalse([m4 isEqualToTypeMirror:m1]);
}

- (void)testHash {
	NSDictionary *test = @{
		[HGBaseTypeMirror createForEncoding:@"q"] : @1,
		[HGBaseTypeMirror createForEncoding:@"q"] : @2,
		[HGBaseTypeMirror createForEncoding:@":"] : @3,
		@":" : @4
	};
	XCTAssertEqual([test count], 3);
	XCTAssertEqualObjects([test objectForKey:@":"], @4);
}

@end
