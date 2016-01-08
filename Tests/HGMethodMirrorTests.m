#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>


@interface HGMethodMirrorTests : XCTestCase

@end


@implementation HGMethodMirrorTests

- (void)testNumberOfArguments {
	HGClassMirror *class = reflect([NSString class]);
	HGMethodMirror *method1 = [class methodNamed:@selector(UTF8String)];
	XCTAssertNotNil(method1);
	XCTAssertEqual([method1 numberOfArguments], 0);
	HGMethodMirror *method2 = [class methodNamed:@selector(initWithFormat:locale:)];
	XCTAssertNotNil(method2);
	XCTAssertEqual([method2 numberOfArguments], 2);
}

- (void)testReturnType {
	HGClassMirror *class = reflect([NSMutableString class]);
	HGMethodMirror *method = [class methodNamed:@selector(deleteCharactersInRange:)];
	XCTAssertNotNil(method);
	id typeMirror = [method returnType];
	XCTAssertEqual([typeMirror class], [HGVoidTypeMirror class]);
}

- (void)testArgumentTypes {
	HGClassMirror *class = reflect([NSString class]);
	HGMethodMirror *method = [class methodNamed:@selector(stringByFoldingWithOptions:locale:)];
	NSArray *argumentTypes = [method argumentTypes];
	XCTAssertEqual([argumentTypes count], 2);
	XCTAssertEqual([[argumentTypes firstObject] class], [HGUnsignedLongLongTypeMirror class]);
	XCTAssertEqual([[argumentTypes lastObject] class], [HGObjectTypeMirror class]);
}

NSUInteger hg_fake_implementation(id self, SEL cmd) {
	return 42;
}

- (void)testReplaceImplementation {
	HGClassMirror *class = reflect([NSObject class]);
	HGMethodMirror *method = [class methodNamed:@selector(hash)];
	NSObject *subject = [[NSObject alloc] init];
	NSUInteger oldHash = [subject hash];
	XCTAssertNotEqual(oldHash, 42);
	IMP oldImp = [method replaceImplementationWith:(IMP)hg_fake_implementation];
	XCTAssertEqual([subject hash], 42);
	[method replaceImplementationWith:oldImp];
	XCTAssertEqual([subject hash], oldHash);
}

@end
