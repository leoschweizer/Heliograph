#import <Foundation/Foundation.h>
#import "HGTypeMirror.h"


@class HGClassMirror;


@interface HGBaseTypeMirror : NSObject <HGTypeMirror>

/**
 * The encoding of the receiver's mirrored type.
 */
@property (nonatomic, readonly) NSString *encoding;

/**
 * Answers an HGTypeMirror reflecting the type specified by anEncoding;
 */
+ (id<HGTypeMirror>)createForEncoding:(NSString *)anEncoding;

@end


@interface HGObjectTypeMirror : HGBaseTypeMirror

/**
 * Answers an HGClassMirror reflecting the class of the receiver's mirrored
 * object.
 */
- (HGClassMirror *)classMirror;

/**
 * Alias for classMirror.
 */
- (HGClassMirror *)type;

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
