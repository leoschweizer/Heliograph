#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGInstanceVariableMirrorTests : XCTestCase

@property (nonatomic, readwrite) NSArray *instanceVariables;

@end


@implementation HGInstanceVariableMirrorTests

- (void)setUp {
	[super setUp];
	self.instanceVariables = [reflect([HGInstanceVariableClass class]) instanceVariables];
}

- (void)testInstanceVariableCount {
	XCTAssertEqual([self.instanceVariables count], 25);
}

- (void)testInstanceVariableName {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"publicIvar"];
	XCTAssertNotNil(mirror);
	XCTAssertEqualObjects(mirror.name, @"publicIvar");
}

- (void)testPrivateInstanceVariables {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testAutoSynthesizedInstanceVariable {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithIvar"];
	XCTAssertNotNil(mirror);
}

- (void)testReadonlyProperty {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithoutIvar"];
	XCTAssertNil(mirror);
}

- (void)testSynthesizedInstanceVariable {
	HGInstanceVariableMirror *mirror1 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"];
	XCTAssertNotNil(mirror1);
	HGInstanceVariableMirror *mirror2 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"propertyWithSynthesizedIvar"];
	XCTAssertNil(mirror2);
}

- (void)testInstanceVariableType {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	XCTAssertEqual([[mirror type] class], [HGCharTypeMirror class]);
}

- (void)testGetMissingInstanceVariable {
	HGInstanceVariableMirror *mirror = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"missing"];
	XCTAssertNil(mirror);
}

- (void)testIsEqual {
	HGInstanceVariableMirror *m1 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	HGInstanceVariableMirror *m2 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"];
	HGInstanceVariableMirror *m3 = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"];
	XCTAssertTrue([m1 isEqual:m1]);
	XCTAssertEqualObjects(m1, m2);
	XCTAssertNotEqualObjects(m2, m3);
	XCTAssertNotEqualObjects(m1, @"");
	XCTAssertNotEqualObjects(m1, nil);
}

- (void)testHash {
	NSDictionary *test = @{
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"] : @1,
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"privateIvar"] : @2,
		[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_propertyWithSynthesizedIvarBaz"] : @3
	};
	XCTAssertEqual([test count], 2);
}

- (void)testReadObjectIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_objectIvar = @42;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_objectIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGObjectMirror class]]);
	XCTAssertEqualObjects([[value mirroredValue] nonretainedObjectValue], @42);
}

- (void)testReadClassIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_classIvar = [NSMutableSet class];
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_classIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGClassMirror class]]);
	XCTAssertEqualObjects([[value mirroredValue] nonretainedObjectValue], [NSMutableSet class]);
	XCTAssertEqualObjects([value valueDescription], @"NSMutableSet");
}

- (void)testReadCharIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_charIvar = -8;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_charIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGCharValueMirror class]]);
	XCTAssertEqual([value charValue], -8);
	XCTAssertEqualObjects([value valueDescription], @"-8");
}

- (void)testReadShortIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_shortIvar = -16;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_shortIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGShortValueMirror class]]);
	XCTAssertEqual([value shortValue], -16);
	XCTAssertEqualObjects([value valueDescription], @"-16");
}

- (void)testReadIntIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_intIvar = -32;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_intIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGIntValueMirror class]]);
	XCTAssertEqual([value intValue], -32);
	XCTAssertEqualObjects([value valueDescription], @"-32");
}

- (void)testReadLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_longIvar = -64;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_longIvar"] valueIn:testObject];
	XCTAssertEqual([value longValue], -64);
	XCTAssertEqualObjects([value valueDescription], @"-64");
}

- (void)testReadLongLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_longLongIvar = -128;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_longLongIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGLongLongValueMirror class]]);
	XCTAssertEqual([value longLongValue], -128);
	XCTAssertEqualObjects([value valueDescription], @"-128");
}

- (void)testReadUcharIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ucharIvar = 8;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ucharIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedCharValueMirror class]]);
	XCTAssertEqual([value unsignedCharValue], 8);
	XCTAssertEqualObjects([value valueDescription], @"8");
}

- (void)testReadUshortIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ushortIvar = 16;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ushortIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedShortValueMirror class]]);
	XCTAssertEqual([value unsignedShortValue], 16);
	XCTAssertEqualObjects([value valueDescription], @"16");
}

- (void)testReadUintIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_uintIvar = 32;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_uintIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedIntValueMirror class]]);
	XCTAssertEqual([value unsignedIntValue], 32);
	XCTAssertEqualObjects([value valueDescription], @"32");
}

- (void)testReadUlongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ulongIvar = 64;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ulongIvar"] valueIn:testObject];
	XCTAssertEqual([value unsignedLongValue], 64);
	XCTAssertEqualObjects([value valueDescription], @"64");
}

- (void)testReadUlongLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ulongLongIvar = 128;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ulongLongIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedLongLongValueMirror class]]);
	XCTAssertEqual([value unsignedLongLongValue], 128);
	XCTAssertEqualObjects([value valueDescription], @"128");
}

- (void)testReadFloatIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_floatIvar = 3.14f;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_floatIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGFloatValueMirror class]]);
	XCTAssertEqual([value floatValue], 3.14f);
	XCTAssertEqualObjects([value valueDescription], @"3.14");
}

- (void)testReadDoubleIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_doubleIvar = 1.33333;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_doubleIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGDoubleValueMirror class]]);
	XCTAssertEqual([value doubleValue], 1.33333);
	XCTAssertEqualObjects([value valueDescription], @"1.33333");
}

- (void)testReadBoolIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_boolIvar = true;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_boolIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGBoolValueMirror class]]);
	XCTAssertTrue([value boolValue]);
	XCTAssertEqualObjects([value valueDescription], @"true");
}

- (void)testReadSelectorIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_selIvar = @selector(didChangeValueForKey:);
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_selIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGSelectorValueMirror class]]);
	XCTAssertEqual([value selectorValue], @selector(didChangeValueForKey:));
	XCTAssertEqualObjects([value valueDescription], @"didChangeValueForKey:");
}

- (void)testReadArrayIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_arrayIvar[0] = 42;
	testObject->_arrayIvar[1] = 1337;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_arrayIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGArrayValueMirror class]]);
	int *result = [[value mirroredValue] pointerValue];
	XCTAssertEqual(result[0], 42);
	XCTAssertEqual(result[1], 1337);
	XCTAssertEqualObjects([value valueDescription], @"[array]");
}

- (void)testReadStructIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_structIvar = CGRectMake(10, 10, 1337, 7331);
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_structIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGStructureValueMirror class]]);
	CGRect rect = *(CGRect *)[[value mirroredValue] pointerValue];
	XCTAssertTrue(CGRectEqualToRect(rect, testObject->_structIvar));
	XCTAssertEqualObjects([value valueDescription], @"{struct}");
}

- (void)testReadUnionIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	union HGMixedType u = { 32 };
	testObject->_unionIvar = u;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_unionIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnionValueMirror class]]);
	union HGMixedType result = *(union HGMixedType *)[[value mirroredValue] pointerValue];
	XCTAssertEqual(result.i, 32);
	XCTAssertEqualObjects([value valueDescription], @"(union)");
}

- (void)testReadPointerIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_pointerIvar = &testObject;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_pointerIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGPointerValueMirror class]]);
	void *p;
	[[value mirroredValue] getValue:&p];
	XCTAssertEqual(p, &testObject);
	XCTAssertEqualObjects([value valueDescription], @"<^>");
}

@end
