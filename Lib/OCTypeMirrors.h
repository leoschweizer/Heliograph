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


@interface OCArrayTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCStructureTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnionTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCBitFieldTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCPointerTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCUnknownTypeMirror : OCTypeMirror

@end
