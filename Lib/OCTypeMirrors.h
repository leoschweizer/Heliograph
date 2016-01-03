#import <Foundation/Foundation.h>


@class OCClassMirror;


@interface OCTypeMirror : NSObject

@property (nonatomic, readonly) NSString *encoding;

+ (instancetype)createForEncoding:(NSString *)encoding;

- (instancetype)initWithEncoding:(NSString *)encoding;

@end


@interface OCObjectTypeMirror : OCTypeMirror

@property (nonatomic, readonly) OCClassMirror *classMirror;

@end


@interface OCClassTypeMirror : OCTypeMirror

@end


@interface OCPrimitiveTypeMirror : OCTypeMirror

@end


@interface OCCharTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCShortTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCIntTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCLongTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCLongLongTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnsignedCharTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnsignedShortTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnsignedIntTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnsignedLongTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCFloatTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCDoubleTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnsignedLongLongTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCBoolTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCCharacterStringTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCSelectorTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCVoidTypeMirror : OCTypeMirror

@end


@interface OCArrayTypeMirror : OCTypeMirror

@end


@interface OCStructureTypeMirror : OCTypeMirror

@end


@interface OCUnionTypeMirror : OCTypeMirror

@end


@interface OCBitFieldTypeMirror : OCTypeMirror

@end


@interface OCPointerTypeMirror : OCTypeMirror

@end


@interface OCUnknownTypeMirror : OCTypeMirror

@end
