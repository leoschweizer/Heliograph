#import "HGTypeMirrors.h"
#import <objc/runtime.h>
#import "HGClassMirror.h"
#import "HGTypeMirrorDescriptionVisitor.h"


@interface HGBaseTypeMirror ()

- (instancetype)initWithEncoding:(NSString *)encoding;

@end


@implementation HGBaseTypeMirror

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

+ (id<HGTypeMirror>)createForEncoding:(NSString *)encoding {
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

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {}

- (NSString *)typeDescription {
	HGTypeMirrorDescriptionVisitor *visitor = [[HGTypeMirrorDescriptionVisitor alloc] init];
	[self acceptTypeMirrorVisitor:visitor];
	return visitor.typeDescription;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)anObject {
	if (anObject == self) {
		return YES;
	}
	if (!anObject || !([anObject class] == [self class])) {
		return NO;
	}
	return [self isEqualToTypeMirror:anObject];
}

- (BOOL)isEqualToTypeMirror:(id<HGTypeMirror>)aTypeMirror {
	return [self.encoding isEqualToString:((HGBaseTypeMirror *)aTypeMirror).encoding];
}

- (NSUInteger)hash {
	return [@"HGTypeMirror" hash] ^ [self.encoding hash];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
	HGBaseTypeMirror *newMirror = [[self.class allocWithZone:zone] init];
	newMirror->_encoding = [_encoding copyWithZone:zone];
	return newMirror;
}

@end


@implementation HGObjectTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitObjectTypeMirror:)]) {
		[aVisitor visitObjectTypeMirror:self];
	}
}

- (HGClassMirror *)classMirror {
	if (self.encoding.length >= 4) {
		NSString *className = [self.encoding substringWithRange:NSMakeRange(2, self.encoding.length - 3)];
		Class class = objc_getClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
		if (class) {
			return [[HGClassMirror alloc] initWithClass:class];
		}
	}
	return nil;
}

- (HGClassMirror *)type {
	return [self classMirror];
}

@end


@implementation HGClassTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitClassTypeMirror:)]) {
		[aVisitor visitClassTypeMirror:self];
	}
}

@end


@implementation HGCharTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitCharTypeMirror:)]) {
		[aVisitor visitCharTypeMirror:self];
	}
}

@end


@implementation HGShortTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitShortTypeMirror:)]) {
		[aVisitor visitShortTypeMirror:self];
	}
}

@end


@implementation HGIntTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitIntTypeMirror:)]) {
		[aVisitor visitIntTypeMirror:self];
	}
}

@end


@implementation HGLongTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongTypeMirror:)]) {
		[aVisitor visitLongTypeMirror:self];
	}
}

@end


@implementation HGLongLongTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitLongLongTypeMirror:)]) {
		[aVisitor visitLongLongTypeMirror:self];
	}
}

@end


@implementation HGUnsignedCharTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedCharTypeMirror:)]) {
		[aVisitor visitUnsignedCharTypeMirror:self];
	}
}

@end


@implementation HGUnsignedShortTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedShortTypeMirror:)]) {
		[aVisitor visitUnsignedShortTypeMirror:self];
	}
}

@end


@implementation HGUnsignedIntTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedIntTypeMirror:)]) {
		[aVisitor visitUnsignedIntTypeMirror:self];
	}
}

@end


@implementation HGUnsignedLongTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongTypeMirror:)]) {
		[aVisitor visitUnsignedLongTypeMirror:self];
	}
}

@end


@implementation HGUnsignedLongLongTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongLongTypeMirror:)]) {
		[aVisitor visitUnsignedLongLongTypeMirror:self];
	}
}

@end


@implementation HGFloatTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitFloatTypeMirror:)]) {
		[aVisitor visitFloatTypeMirror:self];
	}
}

@end


@implementation HGDoubleTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitDoubleTypeMirror:)]) {
		[aVisitor visitDoubleTypeMirror:self];
	}
}

@end


@implementation HGBoolTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBoolTypeMirror:)]) {
		[aVisitor visitBoolTypeMirror:self];
	}
}

@end


@implementation HGCharacterStringTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitCharacterStringTypeMirror:)]) {
		[aVisitor visitCharacterStringTypeMirror:self];
	}
}

@end


@implementation HGSelectorTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitSelectorTypeMirror:)]) {
		[aVisitor visitSelectorTypeMirror:self];
	}
}

@end


@implementation HGVoidTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitVoidTypeMirror:)]) {
		[aVisitor visitVoidTypeMirror:self];
	}
}

@end


@implementation HGArrayTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitArrayTypeMirror:)]) {
		[aVisitor visitArrayTypeMirror:self];
	}
}

@end


@implementation HGStructureTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitStructureTypeMirror:)]) {
		[aVisitor visitStructureTypeMirror:self];
	}
}

@end


@implementation HGUnionTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnionTypeMirror:)]) {
		[aVisitor visitUnionTypeMirror:self];
	}
}

@end


@implementation HGBitFieldTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitBitFieldTypeMirror:)]) {
		[aVisitor visitBitFieldTypeMirror:self];
	}
}

@end


@implementation HGPointerTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitPointerTypeMirror:)]) {
		[aVisitor visitPointerTypeMirror:self];
	}
}

@end


@implementation HGUnknownTypeMirror

- (void)acceptTypeMirrorVisitor:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitUnknownTypeMirror:)]) {
		[aVisitor visitUnknownTypeMirror:self];
	}
}

@end
