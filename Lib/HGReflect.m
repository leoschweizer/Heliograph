#import "HGReflect.h"
#import "HGClassMirror.h"
#import "HGValueMirrors.h"


__attribute__((overloadable)) HGClassMirror * reflect(Class this) {
	return [[HGClassMirror alloc] initWithClass:this];
}

__attribute__((overloadable)) HGObjectMirror * reflect(NSObject *this) {
	return [[HGObjectMirror alloc] initWithObject:this];
}
