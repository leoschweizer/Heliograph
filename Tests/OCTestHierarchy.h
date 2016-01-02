#import <Foundation/Foundation.h>


@interface OCRootClass : NSObject

@end


@interface OCDescendant1 : OCRootClass

- (void)methodDefinedInDescendant1;

@end


@interface OCDescendant2 : OCRootClass

@end


@interface OCDescendant1Descendant1 : OCDescendant1

+ (void)classMethodDefinedInDescendant1Descendant1;
- (void)methodDefinedInDescendant1Descendant1;

@end


@interface OCDescendant1Descendant2 : OCDescendant1

@end


@interface OCPropertyClass : NSObject

@property (nonatomic, readonly, copy) NSString *property1;
@property (atomic, readwrite, weak) id property2;

@end
