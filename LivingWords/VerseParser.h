#import <Foundation/Foundation.h>
#import "ParsedVerse.h"
#import "Verse.h"

@interface VerseParser : NSObject
+ (NSOrderedSet *)parseString:(NSString *)string;
+ (NSString *)displayVerse:(Verse *)verse;
@end
