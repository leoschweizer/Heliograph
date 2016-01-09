#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@class HGClassMirror;


@interface HGBaseTypeMirror : NSObject <HGTypeMirror>

@property (nonatomic, readonly) NSString *encoding;

+ (instancetype)createForEncoding:(NSString *)encoding;

- (instancetype)initWithEncoding:(NSString *)encoding;

@end


@interface HGObjectTypeMirror : HGBaseTypeMirror

@property (nonatomic, readonly) HGClassMirror *classMirror;

@end


@interface HGClassTypeMirror : HGBaseTypeMirror

@end


@interface HGCharTypeMirror : HGBaseTypeMirror

@end


@interface HGShortTypeMirror : HGBaseTypeMirror

@end


@interface HGIntTypeMirror : HGBaseTypeMirror

@end


@interface HGLongTypeMirror : HGBaseTypeMirror

@end


@interface HGLongLongTypeMirror : HGBaseTypeMirror

@end


@interface HGUnsignedCharTypeMirror : HGBaseTypeMirror

@end


@interface HGUnsignedShortTypeMirror : HGBaseTypeMirror

@end


@interface HGUnsignedIntTypeMirror : HGBaseTypeMirror

@end


@interface HGUnsignedLongTypeMirror : HGBaseTypeMirror

@end


@interface HGUnsignedLongLongTypeMirror : HGBaseTypeMirror

@end


@interface HGFloatTypeMirror : HGBaseTypeMirror

@end


@interface HGDoubleTypeMirror : HGBaseTypeMirror

@end


@interface HGBoolTypeMirror : HGBaseTypeMirror

@end


@interface HGCharacterStringTypeMirror : HGBaseTypeMirror

@end


@interface HGSelectorTypeMirror : HGBaseTypeMirror

@end


@interface HGVoidTypeMirror : HGBaseTypeMirror

@end


@interface HGArrayTypeMirror : HGBaseTypeMirror

@end


@interface HGStructureTypeMirror : HGBaseTypeMirror

@end


@interface HGUnionTypeMirror : HGBaseTypeMirror

@end


@interface HGBitFieldTypeMirror : HGBaseTypeMirror

@end


@interface HGPointerTypeMirror : HGBaseTypeMirror

@end


@interface HGUnknownTypeMirror : HGBaseTypeMirror

@end
