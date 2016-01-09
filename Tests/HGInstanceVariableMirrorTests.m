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
}

- (void)testReadCharIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_charIvar = -8;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_charIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGCharValueMirror class]]);
	XCTAssertEqual(*(char *)[[value mirroredValue] pointerValue], -8);
}

- (void)testReadShortIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_shortIvar = -16;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_shortIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGShortValueMirror class]]);
	XCTAssertEqual(*(short *)[[value mirroredValue] pointerValue], -16);
}

- (void)testReadIntIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_intIvar = -32;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_intIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGIntValueMirror class]]);
	XCTAssertEqual(*(short *)[[value mirroredValue] pointerValue], -32);
}

- (void)testReadLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_longIvar = -64;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_longIvar"] valueIn:testObject];
	//XCTAssertTrue([value isKindOfClass:[HGLongValueMirror class]]);
	XCTAssertEqual(*(long *)[[value mirroredValue] pointerValue], -64);
}

- (void)testReadLongLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_longLongIvar = -128;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_longLongIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGLongLongValueMirror class]]);
	XCTAssertEqual(*(long long *)[[value mirroredValue] pointerValue], -128);
}

- (void)testReadUcharIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ucharIvar = 8;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ucharIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedCharValueMirror class]]);
	XCTAssertEqual(*(unsigned char *)[[value mirroredValue] pointerValue], 8);
}

- (void)testReadUshortIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ushortIvar = 16;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ushortIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedShortValueMirror class]]);
	XCTAssertEqual(*(unsigned short *)[[value mirroredValue] pointerValue], 16);
}

- (void)testReadUintIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_uintIvar = 32;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_uintIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedIntValueMirror class]]);
	XCTAssertEqual(*(unsigned int *)[[value mirroredValue] pointerValue], 32);
}

- (void)testReadUlongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ulongIvar = 64;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ulongIvar"] valueIn:testObject];
	//XCTAssertTrue([value isKindOfClass:[HGUnsignedLongValueMirror class]]);
	XCTAssertEqual(*(unsigned long *)[[value mirroredValue] pointerValue], 64);
}

- (void)testReadUlongLongIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_ulongLongIvar = 128;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_ulongLongIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnsignedLongLongValueMirror class]]);
	XCTAssertEqual(*(unsigned long long *)[[value mirroredValue] pointerValue], 128);
}

- (void)testReadFloatIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_floatIvar = 3.14f;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_floatIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGFloatValueMirror class]]);
	XCTAssertEqual(*(float *)[[value mirroredValue] pointerValue], 3.14f);
}

- (void)testReadDoubleIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_doubleIvar = 1.33333;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_doubleIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGDoubleValueMirror class]]);
	XCTAssertEqual(*(double *)[[value mirroredValue] pointerValue], 1.33333);
}

- (void)testReadBoolIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_boolIvar = true;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_boolIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGBoolValueMirror class]]);
	XCTAssertTrue(*(_Bool *)[[value mirroredValue] pointerValue]);
}

- (void)testReadSelectorIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_selIvar = @selector(didChangeValueForKey:);
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_selIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGSelectorValueMirror class]]);
	XCTAssertEqual(*(SEL *)[[value mirroredValue] pointerValue], @selector(didChangeValueForKey:));
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
}

- (void)testReadStructIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_structIvar = CGRectMake(10, 10, 1337, 7331);
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_structIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGStructureValueMirror class]]);
	CGRect rect = *(CGRect *)[[value mirroredValue] pointerValue];
	XCTAssertTrue(CGRectEqualToRect(rect, testObject->_structIvar));
}

- (void)testReadUnionIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	union HGMixedType u = { 32 };
	testObject->_unionIvar = u;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_unionIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnionValueMirror class]]);
	union HGMixedType result = *(union HGMixedType *)[[value mirroredValue] pointerValue];
	XCTAssertEqual(result.i, 32);
}

- (void)testReadPointerIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_pointerIvar = &testObject;
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_pointerIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGPointerValueMirror class]]);
	void *p = *(void **)[[value mirroredValue] pointerValue];
	XCTAssertEqual(p, &testObject);
}

@end
