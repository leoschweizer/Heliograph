#import <XCTest/XCTest.h>
#import <Heliograph/Heliograph.h>
#import "HGTestHierarchy.h"


@interface HGMethodWrapperTest : XCTestCase

@end


@implementation HGMethodWrapperTest

- (void)testWrapper {
	HGMethodWrapper *wrapper = [[HGMethodWrapper alloc] initWithWrappedClass:[HGWrapperTestClass class] wrappedSelector:@selector(testMethodWithArg:)];
	id testDummy = [[HGWrapperTestClass alloc] init];
	[wrapper install];
	int result = [testDummy testMethodWithArg:3];
	[wrapper uninstall];
}

@end
