#import "OCReflect.h"
#import <OpinionatedCMirrors/OCClassMirror.h>
#import <OpinionatedCMirrors/OCValueMirrors.h>


__attribute__((overloadable)) OCClassMirror * reflect(Class this) {
	return [[OCClassMirror alloc] initWithClass:this];
}

__attribute__((overloadable)) OCObjectMirror * reflect(NSObject *this) {
	return [[OCObjectMirror alloc] initWithObject:this];
}
