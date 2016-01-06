#import "HGTypeMirrorVisitor.h"


@implementation HGTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	if ([aVisitor respondsToSelector:@selector(visitTypeMirror:)]) {
		[aVisitor visitTypeMirror:self];
	}
}

@end


@implementation HGObjectTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitObjectTypeMirror:)]) {
		[aVisitor visitObjectTypeMirror:self];
	}
}

@end


@implementation HGClassTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitClassTypeMirror:)]) {
		[aVisitor visitClassTypeMirror:self];
	}
}

@end


@implementation HGPrimitiveTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitPrimitiveTypeMirror:)]) {
		[aVisitor visitPrimitiveTypeMirror:self];
	}
}

@end


@implementation HGCharTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitCharTypeMirror:)]) {
		[aVisitor visitCharTypeMirror:self];
	}
}

@end


@implementation HGShortTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitShortTypeMirror:)]) {
		[aVisitor visitShortTypeMirror:self];
	}
}

@end


@implementation HGIntTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitIntTypeMirror:)]) {
		[aVisitor visitIntTypeMirror:self];
	}
}

@end


@implementation HGLongTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitLongTypeMirror:)]) {
		[aVisitor visitLongTypeMirror:self];
	}
}

@end


@implementation HGLongLongTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitLongLongTypeMirror:)]) {
		[aVisitor visitLongLongTypeMirror:self];
	}
}

@end


@implementation HGUnsignedCharTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnsignedCharTypeMirror:)]) {
		[aVisitor visitUnsignedCharTypeMirror:self];
	}
}

@end


@implementation HGUnsignedShortTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnsignedShortTypeMirror:)]) {
		[aVisitor visitUnsignedShortTypeMirror:self];
	}
}

@end


@implementation HGUnsignedIntTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnsignedIntTypeMirror:)]) {
		[aVisitor visitUnsignedIntTypeMirror:self];
	}
}

@end


@implementation HGUnsignedLongTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongTypeMirror:)]) {
		[aVisitor visitUnsignedLongTypeMirror:self];
	}
}

@end


@implementation HGUnsignedLongLongTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnsignedLongLongTypeMirror:)]) {
		[aVisitor visitUnsignedLongLongTypeMirror:self];
	}
}

@end


@implementation HGFloatTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitFloatTypeMirror:)]) {
		[aVisitor visitFloatTypeMirror:self];
	}
}

@end


@implementation HGDoubleTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitDoubleTypeMirror:)]) {
		[aVisitor visitDoubleTypeMirror:self];
	}
}

@end


@implementation HGBoolTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitBoolTypeMirror:)]) {
		[aVisitor visitBoolTypeMirror:self];
	}
}

@end


@implementation HGCharacterStringTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitCharacterStringTypeMirror:)]) {
		[aVisitor visitCharacterStringTypeMirror:self];
	}
}

@end


@implementation HGSelectorTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitSelectorTypeMirror:)]) {
		[aVisitor visitSelectorTypeMirror:self];
	}
}

@end


@implementation HGVoidTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitVoidTypeMirror:)]) {
		[aVisitor visitVoidTypeMirror:self];
	}
}

@end


@implementation HGArrayTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitArrayTypeMirror:)]) {
		[aVisitor visitArrayTypeMirror:self];
	}
}

@end


@implementation HGStructureTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitStructureTypeMirror:)]) {
		[aVisitor visitStructureTypeMirror:self];
	}
}

@end


@implementation HGUnionTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnionTypeMirror:)]) {
		[aVisitor visitUnionTypeMirror:self];
	}
}

@end


@implementation HGBitFieldTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitBitFieldTypeMirror:)]) {
		[aVisitor visitBitFieldTypeMirror:self];
	}
}

@end


@implementation HGPointerTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitPointerTypeMirror:)]) {
		[aVisitor visitPointerTypeMirror:self];
	}
}

@end


@implementation HGUnknownTypeMirror (HGTypeMirrorVisitorSupport)

- (void)accept:(id<HGTypeMirrorVisitor>)aVisitor {
	[super accept:aVisitor];
	if ([aVisitor respondsToSelector:@selector(visitUnknownTypeMirror:)]) {
		[aVisitor visitUnknownTypeMirror:self];
	}
}

@end
