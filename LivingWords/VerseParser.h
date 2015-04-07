#import <Foundation/Foundation.h>
#import "ParsedVerse.h"

@interface VerseParser : NSObject
+ (NSSet *)parseString:(NSString *)string;
@end
