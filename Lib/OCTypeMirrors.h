#import <Foundation/Foundation.h>


@class OCClassMirror;


@interface OCTypeMirror : NSObject

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


@interface OCIntTypeMirror : OCPrimitiveTypeMirror

@end


@interface OCBoolTypeMirror : OCPrimitiveTypeMirror

@end
