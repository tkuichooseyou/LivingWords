#import <Foundation/Foundation.h>
#import "ParsedVerse.h"

@interface VerseParser : NSObject
+ (NSOrderedSet *)parseString:(NSString *)string;
@end
