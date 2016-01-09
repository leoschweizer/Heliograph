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


@interface HGPrimitiveTypeMirror : HGBaseTypeMirror

@end


@interface HGCharTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGShortTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGIntTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGLongTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGLongLongTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnsignedCharTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnsignedShortTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnsignedIntTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnsignedLongTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnsignedLongLongTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGFloatTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGDoubleTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGBoolTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGCharacterStringTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGSelectorTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGVoidTypeMirror : HGBaseTypeMirror

@end


@interface HGArrayTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGStructureTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnionTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGBitFieldTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGPointerTypeMirror : HGPrimitiveTypeMirror

@end


@interface HGUnknownTypeMirror : HGBaseTypeMirror

@end
