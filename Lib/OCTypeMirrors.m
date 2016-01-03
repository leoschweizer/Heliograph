#import "OCTypeMirrors.h"
#import <objc/runtime.h>
#import "OCClassMirror.h"


@implementation OCTypeMirror

+ (NSDictionary *)typeEncodings {
	static dispatch_once_t onceToken;
	static NSDictionary *_dict = nil;
	dispatch_once(&onceToken, ^{
		_dict = @{
			@('@') : [OCObjectTypeMirror class],
			@('#') : [OCClassTypeMirror class],
			@('c') : [OCCharTypeMirror class],
			@('s') : [OCShortTypeMirror class],
			@('i') : [OCIntTypeMirror class],
			@('l') : [OCLongTypeMirror class],
			@('q') : [OCLongLongTypeMirror class],
			@('C') : [OCUnsignedCharTypeMirror class],
			@('S') : [OCUnsignedShortTypeMirror class],
			@('I') : [OCUnsignedIntTypeMirror class],
			@('L') : [OCUnsignedLongTypeMirror class],
			@('Q') : [OCUnsignedLongLongTypeMirror class],
			@('f') : [OCFloatTypeMirror class],
			@('d') : [OCDoubleTypeMirror class],
			@('B') : [OCBoolTypeMirror class],
			@('*') : [OCCharacterStringTypeMirror class],
			@(':') : [OCSelectorTypeMirror class],
			@('v') : [OCVoidTypeMirror class],
			@('[') : [OCArrayTypeMirror class],
			@('{') : [OCStructureTypeMirror class],
			@('(') : [OCUnionTypeMirror class],
			@('b') : [OCBitFieldTypeMirror class],
			@('^') : [OCPointerTypeMirror class],
			@('?') : [OCUnknownTypeMirror class]
		};
	});
	return _dict;
}

+ (instancetype)createForEncoding:(NSString *)encoding {
	Class class = [[self typeEncodings] objectForKey:@([encoding characterAtIndex:0])];
	if (class) {
		return [[class alloc] initWithEncoding:encoding];
	}
	return [[OCUnknownTypeMirror alloc] initWithEncoding:encoding];
}

- (instancetype)initWithEncoding:(NSString *)encoding {
	if (self = [super init]) {
		_encoding = encoding;
	}
	return self;
}

@end


@implementation OCObjectTypeMirror

- (instancetype)initWithEncoding:(NSString *)encoding {
	if (self = [super initWithEncoding:encoding]) {
		if (encoding.length >= 4) {
			NSString *className = [encoding substringWithRange:NSMakeRange(2, encoding.length - 3)];
			Class class = objc_getClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
			if (class) {
				_classMirror = [[OCClassMirror alloc] initWithClass:class];
			}
		}
	}
	return self;
}

@end


@implementation OCClassTypeMirror

@end


@implementation OCPrimitiveTypeMirror

@end


@implementation OCCharTypeMirror

@end


@implementation OCShortTypeMirror

@end


@implementation OCIntTypeMirror

@end


@implementation OCLongTypeMirror

@end


@implementation OCLongLongTypeMirror

@end


@implementation OCUnsignedCharTypeMirror

@end


@implementation OCUnsignedShortTypeMirror

@end


@implementation OCUnsignedIntTypeMirror

@end


@implementation OCUnsignedLongTypeMirror

@end


@implementation OCUnsignedLongLongTypeMirror

@end


@implementation OCFloatTypeMirror

@end


@implementation OCDoubleTypeMirror

@end


@implementation OCBoolTypeMirror

@end


@implementation OCCharacterStringTypeMirror

@end


@implementation OCSelectorTypeMirror

@end


@implementation OCVoidTypeMirror

@end


@implementation OCArrayTypeMirror

@end


@implementation OCStructureTypeMirror

@end


@implementation OCUnionTypeMirror

@end


@implementation OCBitFieldTypeMirror

@end


@implementation OCPointerTypeMirror

@end


@implementation OCUnknownTypeMirror

@end
