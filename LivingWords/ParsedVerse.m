#import "ParsedVerse.h"

@implementation ParsedVerse

- (NSString *)urlString
{
    return [NSString stringWithFormat:@"%@/%@/%@", self.book, self.chapterStart, self.numberStart];
}

@end
