#import <Foundation/Foundation.h>


@protocol HGTestProtocol

@required
- (void)requiredInstanceMethod;
+ (id)requiredClassMethodWithArgument:(BOOL)arg;

@optional
- (NSString *)optionalInstanceMethod;
+ (id<NSSecureCoding>)optionalClassMethod:(NSUInteger)arg;

@end


@interface HGRootClass : NSObject

@end


@interface HGDescendant1 : HGRootClass

- (void)methodDefinedInDescendant1;

@end


@interface HGDescendant2 : HGRootClass

@end


@interface HGDescendant1Descendant1 : HGDescendant1

+ (void)classMethodDefinedInDescendant1Descendant1;
- (void)methodDefinedInDescendant1Descendant1;

@end


@interface HGDescendant1Descendant2 : HGDescendant1

@end


@interface HGPropertyClass : NSObject

@property (nonatomic, readonly, copy) NSString *property1;
@property (atomic, readwrite, weak) id property2;
@property (setter=setFoo:, getter=getBar) BOOL baz;

@end


union HGMixedType {
	int i;
	float f;
	char c;
};

typedef struct HGTestStruct {
	int i;
	CGRect rect;
	CGPoint point;
} HGTestStruct;

@interface HGInstanceVariableClass : NSObject {
	
	id publicIvar;
	
	@public
	id _objectIvar;
	Class _classIvar;
	char _charIvar;
	short _shortIvar;
	int _intIvar;
	long _longIvar;
	long long _longLongIvar;
	unsigned char _ucharIvar;
	unsigned short _ushortIvar;
	unsigned int _uintIvar;
	unsigned long _ulongIvar;
	unsigned long long _ulongLongIvar;
	float _floatIvar;
	double _doubleIvar;
	_Bool _boolIvar;
	SEL _selIvar;
	char *_charPointerIvar;
	int _arrayIvar[2];
	CGRect _structIvar;
	union HGMixedType _unionIvar;
	void *_pointerIvar;
	
}

@property (nonatomic, readonly) id propertyWithoutIvar;
@property id propertyWithIvar;
@property id propertyWithSynthesizedIvar;

@end


@interface HGTypeTestClass : NSObject

@property NSString *stringProperty;
@property id idProperty;
@property Class classProperty;
@property char charProperty;
@property int intProperty;
@property _Bool boolProperty;

@end


@interface HGWrapperTestClass : NSObject

- (int)testMethodWithArg:(int)arg;

@end
