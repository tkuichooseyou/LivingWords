#import <Foundation/Foundation.h>
#import "ParsedVerse.h"
#import "Verse.h"

@interface VerseParser : NSObject
+ (NSArray *)parseString:(NSString *)string;
+ (NSString *)displayVerse:(Verse *)verse;
@end
