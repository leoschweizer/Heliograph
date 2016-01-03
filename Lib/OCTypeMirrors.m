#import "OCTypeMirrors.h"
#import <objc/runtime.h>
#import "OCClassMirror.h"


@implementation OCTypeMirror

+ (NSDictionary *)typeEncodings {
	static dispatch_once_t onceToken;
	static NSDictionary *_dict = nil;
	dispatch_once(&onceToken, ^{
		_dict = @{
			@(@encode(id)[0]) : [OCObjectTypeMirror class],
			@(@encode(Class)[0]) : [OCClassTypeMirror class],
			@(@encode(char)[0]) : [OCCharTypeMirror class],
			@(@encode(int)[0]) : [OCIntTypeMirror class],
			@(@encode(_Bool)[0]) : [OCBoolTypeMirror class],
			@(@encode(void)[0]) : [OCVoidTypeMirror class]
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


@implementation OCIntTypeMirror

@end


@implementation OCBoolTypeMirror

@end


@implementation OCVoidTypeMirror

@end


@implementation OCUnknownTypeMirror

@end
