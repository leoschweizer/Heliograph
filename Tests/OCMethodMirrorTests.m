#import <XCTest/XCTest.h>
#import <OpinionatedCMirrors/OpinionatedCMirrors.h>


@interface OCMethodMirrorTests : XCTestCase

@end


@implementation OCMethodMirrorTests

- (void)testNumberOfArguments {
	OCClassMirror *class = reflect([NSString class]);
	NSDictionary *methodDict = [class methodDictionary];
	OCMethodMirror *method1 = [methodDict objectForKey:@"UTF8String"];
	XCTAssertNotNil(method1);
	XCTAssertEqual([method1 numberOfArguments], 0);
	OCMethodMirror *method2 = [methodDict objectForKey:@"initWithFormat:locale:"];
	XCTAssertNotNil(method2);
	XCTAssertEqual([method2 numberOfArguments], 2);
}

- (void)testReturnType {
	OCClassMirror *class = reflect([NSMutableString class]);
	NSDictionary *methodDict = [class methodDictionary];
	OCMethodMirror *method = [methodDict objectForKey:@"deleteCharactersInRange:"];
	XCTAssertNotNil(method);
	id typeMirror = [method returnType];
	XCTAssertEqual([typeMirror class], [OCVoidTypeMirror class]);
}

@end
