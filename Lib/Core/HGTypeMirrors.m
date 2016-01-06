#import "HGTypeMirrors.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"


@implementation HGTypeMirror

+ (NSDictionary *)typeEncodings {
	static dispatch_once_t onceToken;
	static NSDictionary *_dict = nil;
	dispatch_once(&onceToken, ^{
		_dict = @{
			@(_C_ID) : [HGObjectTypeMirror class],
			@(_C_CLASS) : [HGClassTypeMirror class],
			@(_C_CHR) : [HGCharTypeMirror class],
			@(_C_SHT) : [HGShortTypeMirror class],
			@(_C_INT) : [HGIntTypeMirror class],
			@(_C_LNG) : [HGLongTypeMirror class],
			@(_C_LNG_LNG) : [HGLongLongTypeMirror class],
			@(_C_UCHR) : [HGUnsignedCharTypeMirror class],
			@(_C_USHT) : [HGUnsignedShortTypeMirror class],
			@(_C_UINT) : [HGUnsignedIntTypeMirror class],
			@(_C_ULNG) : [HGUnsignedLongTypeMirror class],
			@(_C_ULNG_LNG) : [HGUnsignedLongLongTypeMirror class],
			@(_C_FLT) : [HGFloatTypeMirror class],
			@(_C_DBL) : [HGDoubleTypeMirror class],
			@(_C_BOOL) : [HGBoolTypeMirror class],
			@(_C_CHARPTR) : [HGCharacterStringTypeMirror class],
			@(_C_SEL) : [HGSelectorTypeMirror class],
			@(_C_VOID) : [HGVoidTypeMirror class],
			@(_C_ARY_B) : [HGArrayTypeMirror class],
			@(_C_STRUCT_B) : [HGStructureTypeMirror class],
			@(_C_UNION_B) : [HGUnionTypeMirror class],
			@(_C_BFLD) : [HGBitFieldTypeMirror class],
			@(_C_PTR) : [HGPointerTypeMirror class],
			@(_C_UNDEF) : [HGUnknownTypeMirror class]
		};
	});
	return _dict;
}

+ (instancetype)createForEncoding:(NSString *)encoding {
	Class class = [[self typeEncodings] objectForKey:@([encoding characterAtIndex:0])];
	if (class) {
		return [[class alloc] initWithEncoding:encoding];
	}
	return [[HGUnknownTypeMirror alloc] initWithEncoding:encoding];
}

- (instancetype)initWithEncoding:(NSString *)encoding {
	if (self = [super init]) {
		_encoding = encoding;
	}
	return self;
}

@end


@implementation HGObjectTypeMirror

- (instancetype)initWithEncoding:(NSString *)encoding {
	if (self = [super initWithEncoding:encoding]) {
		if (encoding.length >= 4) {
			NSString *className = [encoding substringWithRange:NSMakeRange(2, encoding.length - 3)];
			Class class = objc_getClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
			if (class) {
				_classMirror = [[HGClassMirror alloc] initWithClass:class];
			}
		}
	}
	return self;
}

@end


@implementation HGClassTypeMirror

@end


@implementation HGPrimitiveTypeMirror

@end


@implementation HGCharTypeMirror

@end


@implementation HGShortTypeMirror

@end


@implementation HGIntTypeMirror

@end


@implementation HGLongTypeMirror

@end


@implementation HGLongLongTypeMirror

@end


@implementation HGUnsignedCharTypeMirror

@end


@implementation HGUnsignedShortTypeMirror

@end


@implementation HGUnsignedIntTypeMirror

@end


@implementation HGUnsignedLongTypeMirror

@end


@implementation HGUnsignedLongLongTypeMirror

@end


@implementation HGFloatTypeMirror

@end


@implementation HGDoubleTypeMirror

@end


@implementation HGBoolTypeMirror

@end


@implementation HGCharacterStringTypeMirror

@end


@implementation HGSelectorTypeMirror

@end


@implementation HGVoidTypeMirror

@end


@implementation HGArrayTypeMirror

@end


@implementation HGStructureTypeMirror

@end


@implementation HGUnionTypeMirror

@end


@implementation HGBitFieldTypeMirror

@end


@implementation HGPointerTypeMirror

@end


@implementation HGUnknownTypeMirror

@end
