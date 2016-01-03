#import <Foundation/Foundation.h>


@class HGClassMirror;
@class HGObjectMirror;


extern HGClassMirror * reflect(Class this) __attribute__((overloadable));

extern HGObjectMirror * reflect(NSObject *this) __attribute__((overloadable));
