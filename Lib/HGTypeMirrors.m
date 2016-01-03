#import "HGTypeMirrors.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"


@implementation HGTypeMirror

+ (NSDictionary *)typeEncodings {
	static dispatch_once_t onceToken;
	static NSDictionary *_dict = nil;
	dispatch_once(&onceToken, ^{
		_dict = @{
			@('@') : [HGObjectTypeMirror class],
			@('#') : [HGClassTypeMirror class],
			@('c') : [HGCharTypeMirror class],
			@('s') : [HGShortTypeMirror class],
			@('i') : [HGIntTypeMirror class],
			@('l') : [HGLongTypeMirror class],
			@('q') : [HGLongLongTypeMirror class],
			@('C') : [HGUnsignedCharTypeMirror class],
			@('S') : [HGUnsignedShortTypeMirror class],
			@('I') : [HGUnsignedIntTypeMirror class],
			@('L') : [HGUnsignedLongTypeMirror class],
			@('Q') : [HGUnsignedLongLongTypeMirror class],
			@('f') : [HGFloatTypeMirror class],
			@('d') : [HGDoubleTypeMirror class],
			@('B') : [HGBoolTypeMirror class],
			@('*') : [HGCharacterStringTypeMirror class],
			@(':') : [HGSelectorTypeMirror class],
			@('v') : [HGVoidTypeMirror class],
			@('[') : [HGArrayTypeMirror class],
			@('{') : [HGStructureTypeMirror class],
			@('(') : [HGUnionTypeMirror class],
			@('b') : [HGBitFieldTypeMirror class],
			@('^') : [HGPointerTypeMirror class],
			@('?') : [HGUnknownTypeMirror class]
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
