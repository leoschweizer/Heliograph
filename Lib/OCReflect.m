#import "OCReflect.h"
#import <OpinionatedCMirrors/OCClassMirror.h>


__attribute__((overloadable)) OCClassMirror * reflect(Class this) {
	return [[OCClassMirror alloc] initWithClass:this];
}

__attribute__((overloadable)) id reflect(id this) {
	return nil;
}
