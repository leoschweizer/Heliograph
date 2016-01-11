#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


#define NSStringize_helper(x) #x
#define NSStringize(x) @NSStringize_helper(x)

#define TestRead(TYPE, VALUE, IVAR, ACCESSOR) \
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init]; \
	testObject->IVAR = VALUE; \
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:NSStringize(IVAR)] valueIn:testObject]; \
	XCTAssertNotNil(value); \
	XCTAssertEqual([value ACCESSOR], VALUE);
	
#define TestWrite(TYPE, VALUE, IVAR) \
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init]; \
	TYPE value = VALUE; \
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:NSStringize(IVAR)]; \
	XCTAssertNotNil(ivar); \
	[ivar setValue:[NSValue valueWithBytes:&value objCType:@encode(TYPE)] in:testObject]; \
	XCTAssertEqual(value, testObject->IVAR);


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
	XCTAssertEqualObjects([value valueDescription], [@42 description]);
}

- (void)testWriteObjectIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_objectIvar"];
	XCTAssertNotNil(ivar);
	[ivar setValue:@1337 in:testObject];
	XCTAssertEqualObjects(@1337, testObject->_objectIvar);
}

- (void)testReadClassIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_classIvar = [NSMutableSet class];
	id<HGValueMirror> value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_classIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGClassMirror class]]);
	XCTAssertEqualObjects([[value mirroredValue] nonretainedObjectValue], [NSMutableSet class]);
	XCTAssertEqualObjects([value valueDescription], @"NSMutableSet");
}

- (void)testWriteClassIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_classIvar"];
	XCTAssertNotNil(ivar);
	[ivar setValue:[NSString class] in:testObject];
	XCTAssertEqualObjects([NSString class], testObject->_classIvar);
}

- (void)testReadCharIvar {
	TestRead(char, -8, _charIvar, charValue);
}

- (void)testWriteCharIvar {
	TestWrite(char, -8, _charIvar);
}

- (void)testReadShortIvar {
	TestRead(short, -16, _shortIvar, shortValue);
}

- (void)testWriteShortIvar {
	TestWrite(short, -16, _shortIvar);
}

- (void)testReadIntIvar {
	TestRead(int, -32, _intIvar, intValue);
}

- (void)testWriteIntIvar {
	TestWrite(int, -32, _intIvar);
}

- (void)testReadLongIvar {
	TestRead(long, -64, _longIvar, longValue);
}

- (void)testWriteLongIvar {
	TestWrite(long, -64, _longIvar);
}

- (void)testReadLongLongIvar {
	TestRead(long long, -128, _longLongIvar, longLongValue);
}

- (void)testWriteLongLongIvar {
	TestWrite(long long, -128, _longLongIvar);
}

- (void)testReadUcharIvar {
	TestRead(unsigned char, 8, _ucharIvar, unsignedCharValue);
}

- (void)testWriteUCharIvar {
	TestWrite(unsigned char, 8, _ucharIvar);
}

- (void)testReadUshortIvar {
	TestRead(unsigned short, 16, _ushortIvar, unsignedShortValue);
}

- (void)testWriteUShortIvar {
	TestWrite(unsigned short, 16, _ushortIvar);
}

- (void)testReadUintIvar {
	TestRead(unsigned int, 32, _uintIvar, unsignedIntValue);
}

- (void)testWriteUIntIvar {
	TestWrite(unsigned int, 32, _uintIvar);
}

- (void)testReadUlongIvar {
	TestRead(unsigned long, 64, _ulongIvar, unsignedLongValue);
}

- (void)testWriteULongIvar {
	TestWrite(unsigned long, 64, _ulongIvar);
}

- (void)testReadUlongLongIvar {
	TestRead(unsigned long long, 128, _ulongLongIvar, unsignedLongLongValue);
}

- (void)testWriteULongLongIvar {
	TestWrite(unsigned long long, 128, _ulongLongIvar);
}

- (void)testReadFloatIvar {
	TestRead(float, 3.14f, _floatIvar, floatValue);
}

- (void)testWriteFloatIvar {
	TestWrite(float, 3.14f, _floatIvar);
}

- (void)testReadDoubleIvar {
	TestRead(double, 1.33333, _doubleIvar, doubleValue);
}

- (void)testWriteDoubleIvar {
	TestWrite(double, 1.33333, _doubleIvar);
}

- (void)testReadBoolIvar {
	TestRead(_Bool, true, _boolIvar, boolValue);
}

- (void)testWriteBoolIvar {
	TestWrite(_Bool, true, _boolIvar);
}

- (void)testReadCharPointerIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_charPointerIvar = "asdfjkl";
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_charPointerIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGCharacterStringValueMirror class]]);
	XCTAssertTrue(strcmp([value characterStringValue], "asdfjkl") == 0);
}

- (void)testWriteCharPointerIvar {
	TestWrite(char *, "qwerty", _charPointerIvar);
}

- (void)testReadSelectorIvar {
	TestRead(SEL, @selector(predicateWithLeftExpression:rightExpression:modifier:type:options:), _selIvar, selectorValue);
}

- (void)testWriteSelectorIvar {
	TestWrite(SEL, @selector(didChangeValueForKey:withSetMutation:usingObjects:), _selIvar);
}

- (void)testReadArrayIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_arrayIvar[0] = 42;
	testObject->_arrayIvar[1] = 1337;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_arrayIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGArrayValueMirror class]]);
	int result[2];
	[value readArrayValue:&result];
	XCTAssertEqual(result[0], 42);
	XCTAssertEqual(result[1], 1337);
	XCTAssertEqualObjects([value valueDescription], @"[array]");
}

- (void)testWriteArrayIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_arrayIvar"];
	XCTAssertNotNil(ivar);
	int testArray[2];
	testArray[0] = 1337;
	testArray[1] = 7331;
	[ivar setValue:[NSValue valueWithBytes:&testArray objCType:@encode(int[2])] in:testObject];
	XCTAssertEqual(testObject->_arrayIvar[0], 1337);
	XCTAssertEqual(testObject->_arrayIvar[1], 7331);
}

- (void)testReadStructIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	testObject->_structIvar = CGRectMake(10, 10, 1337, 7331);
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_structIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGStructureValueMirror class]]);
	CGRect rect1 = [[value mirroredValue] rectValue];
	CGRect rect2;
	[value readStructureValue:&rect2];
	XCTAssertTrue(CGRectEqualToRect(rect1, testObject->_structIvar));
	XCTAssertTrue(CGRectEqualToRect(rect2, testObject->_structIvar));
	XCTAssertEqualObjects([value valueDescription], @"{struct}");
}

- (void)testWriteStructIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_structIvar"];
	XCTAssertNotNil(ivar);
	CGRect rect = CGRectMake(1, 2, 3, 4);
	[ivar setValue:[NSValue valueWithBytes:&rect objCType:@encode(CGRect)] in:testObject];
	XCTAssertTrue(CGRectEqualToRect(rect, testObject->_structIvar));
}

- (void)testReadUnionIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	union HGMixedType u = { 32 };
	testObject->_unionIvar = u;
	id value = [[reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_unionIvar"] valueIn:testObject];
	XCTAssertTrue([value isKindOfClass:[HGUnionValueMirror class]]);
	union HGMixedType result;
	[value readUnionValue:&result];
	XCTAssertEqual(result.i, 32);
	XCTAssertEqualObjects([value valueDescription], @"(union)");
}

- (void)testWriteUnionIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_unionIvar"];
	XCTAssertNotNil(ivar);
	union HGMixedType u = { 44 };
	[ivar setValue:[NSValue valueWithBytes:&u objCType:@encode(union HGMixedType)] in:testObject];
	XCTAssertEqual(testObject->_unionIvar.i, 44);
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

- (void)testWritePointerIvar {
	HGInstanceVariableClass *testObject = [[HGInstanceVariableClass alloc] init];
	HGInstanceVariableMirror *ivar = [reflect([HGInstanceVariableClass class]) instanceVariableNamed:@"_pointerIvar"];
	XCTAssertNotNil(ivar);
	[ivar setValue:[NSValue valueWithBytes:&testObject objCType:@encode(void *)] in:testObject];
	XCTAssertEqual(testObject, testObject->_pointerIvar);
}

@end
