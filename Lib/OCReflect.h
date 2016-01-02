#ifndef OCReflect_h
#define OCReflect_h

@class OCClassMirror;

__attribute__((overloadable)) OCClassMirror * reflect(Class this);
__attribute__((overloadable)) id reflect(id this);

#endif
