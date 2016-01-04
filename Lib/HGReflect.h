#import <Foundation/Foundation.h>


@class HGClassMirror;
@class HGObjectMirror;
@class HGProtocolMirror;


extern HGClassMirror * reflect(Class this) __attribute__((overloadable));

extern HGObjectMirror * reflect(NSObject *this) __attribute__((overloadable));

extern HGProtocolMirror * reflect(Protocol *this) __attribute__((overloadable));
