#ifndef OCReflect_h
#define OCReflect_h

@class NSObject;
@class OCClassMirror;
@class OCObjectMirror;

extern OCClassMirror * reflect(Class this) __attribute__((overloadable));
extern OCObjectMirror * reflect(NSObject *this) __attribute__((overloadable));

#endif
