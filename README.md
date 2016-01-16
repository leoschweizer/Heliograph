# Heliograph
[![Build Status](https://travis-ci.org/leoschweizer/Heliograph.svg?branch=master)](https://travis-ci.org/leoschweizer/Heliograph)
[![Coverage Status](https://coveralls.io/repos/leoschweizer/Heliograph/badge.svg?branch=master&service=github)](https://coveralls.io/github/leoschweizer/Heliograph?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Heliograph is an object-oriented, [mirror-based](https://en.wikipedia.org/wiki/Mirror_(programming)), extensible wrapper around Objective-C's runtime reflection capabilities.

## Building
The easiest way to include Heliograph in your project is through [CocoaPods](http://cocoapods.org/):
```
pod 'Heliograph'
```

Heliograph also supports [Carthage](https://github.com/Carthage/Carthage):
```
github "leoschweizer/Heliograph"
```

## Usage
The central entry point into the mirrored reflection world is the `reflect` function:
```objectivec
#import <Heliograph/Heliograph.h>

HGClassMirror *classMirror = reflect([NSString class]);
HGProtocolMirror *protocolMirror = reflect(@protocol(NSSecureCoding));
HGObjectMirror *objectMirror = reflect(@"Heliograph");
```

**Fun fact:** You can use Heliograph to reason about the functionality of Heliograph!
```objectivec
#import <Heliograph/Heliograph.h>

HGClassMirror *class = reflect([HGClassMirror class]);
for (HGMethodMirror *each in [class methods]) {
    NSLog(@"- %@", NSStringFromSelector([each selector]));
}
for (HGMethodMirror *each in [[class classMirror] methods]) {
    NSLog(@"+ %@", NSStringFromSelector([each selector]));
}
	
// =>
// - classMirror
// - adoptedProtocols
// - adoptProtocol:
// - isMetaclass
// - instanceVariableNamed:
// - methodNamed:
// - subclasses
// - addInstanceVariableNamed:withEncoding:
// - addMethodNamed:withImplementation:andEncoding:
// - addSubclassNamed:
// - allSubclasses
// - allSuperclasses
// - instanceVariables
// - mirroredClass
// - registerClass
// - methods
// - name
// - superclass
// - properties
// - propertyNamed:
// - siblings
// ...
// + allClasses

HGMethodMirror *method = [class methodNamed:@selector(addMethodNamed:withImplementation:andEncoding:)];
for (id<HGTypeMirror> each in [method argumentTypes]) {
    NSLog(@"%@", [each typeDescription]);
}

// =>
// SEL
// ^
// unknown type

```

## Example Snippets
Note: Heliograph works hand in glove with [OpinionatedC](https://github.com/leoschweizer/OpinionatedC), that's why many
of the snippets listed here use both Heliograph and OpinionatedC!
* [Finding the longest class name in your runtime environment](https://gist.github.com/leoschweizer/13d204773c3c65cf9f06)
* [Finding the longest method name in your runtime environment](https://gist.github.com/leoschweizer/5e2fae183fe4cb53dbde)
* [Finding the class with the most instance variables in your runtime environment](https://gist.github.com/leoschweizer/f6fc9fe822473b9de0af)
* [Finding the class with the longest inheritance chain in your runtime environment](https://gist.github.com/leoschweizer/dd121adf4898e0d571d1)
* [Add your own snippet!](https://github.com/leoschweizer/Heliograph/edit/master/README.md#fork-destination-box)

## Contributing
If you have any questions, remarks, ideas or suggestions for improvement, don't hesitate to [open an issue](https://github.com/leoschweizer/Heliograph/issues). If you are about to create a pull request, there are only a few things to consider:
* open an issue first if you are not sure if your idea will be appreciated
* indent with tabs, not spaces
* write unit tests, aim for 100% coverage

## Contributors
* [Leo Schweizer](https://github.com/leoschweizer)

## License
```
The MIT License (MIT)

Copyright (c) 2016 Leo Schweizer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
