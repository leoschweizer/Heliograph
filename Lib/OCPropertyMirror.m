#import "OCPropertyMirror.h"
#import <objc/runtime.h>


static NSArray * parseAttributes(const char * attributes) {
	NSString *result = [NSString stringWithUTF8String:attributes];
	// The string starts with a T followed by the @encode type and a comma,
	// and finishes with a V followed by the name of the backing instance
	// variable. Between these, the attributes are specified by descriptors
	// and separated by commas.
	return [result componentsSeparatedByString:@","];
}


@interface OCPropertyMirror ()

@property (nonatomic, readonly) NSArray *attributes;

@end


@implementation OCPropertyMirror

- (instancetype)initWithDefiningClass:(OCClassMirror *)definingClass property:(objc_property_t)aProperty {
	if (self = [super init]) {
		_mirroredProperty = aProperty;
		_definingClass = definingClass;
		_attributes = parseAttributes(property_getAttributes(_mirroredProperty));
	}
	return self;
}

- (BOOL)isReadonly {
	return [self.attributes containsObject:@"R"];
}

- (NSString *)name {
	return [NSString stringWithUTF8String:property_getName(self.mirroredProperty)];
}

@end
