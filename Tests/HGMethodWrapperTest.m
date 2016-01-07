#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGTestWrapper : HGMethodWrapper

@property (nonatomic, readwrite) NSUInteger beforeCount;
@property (nonatomic, readwrite) NSUInteger afterCount;

@end


@implementation HGTestWrapper

- (void)invocation:(NSInvocation *)invocation withTarget:(id)anObject {
	[self beforeMethod];
	[invocation invoke];
	int result;
	[invocation getReturnValue:&result];
	result++;
	[invocation setReturnValue:&result];
	[self afterMethod];
}

- (void)beforeMethod {
	self.beforeCount++;
}

- (void)afterMethod {
	self.afterCount++;
}

@end


@interface HGMethodWrapperTest : XCTestCase

@end


@implementation HGMethodWrapperTest

- (void)testWrapper {
	HGTestWrapper *wrapper = [[HGTestWrapper alloc] initWithWrappedClass:[HGWrapperTestClass class] wrappedSelector:@selector(testMethodWithArg:)];
	HGWrapperTestClass *testDummy = [[HGWrapperTestClass alloc] init];
	XCTAssertEqual([testDummy testMethodWithArg:5], 10);
	[wrapper install];
	XCTAssertEqual(wrapper.beforeCount, 0);
	XCTAssertEqual(wrapper.afterCount, 0);
	XCTAssertEqual([testDummy testMethodWithArg:5], 11);
	XCTAssertEqual(wrapper.beforeCount, 1);
	XCTAssertEqual(wrapper.afterCount, 1);
	[wrapper uninstall];
	//XCTAssertEqual([testDummy testMethodWithArg:5], 10);
}

@end
