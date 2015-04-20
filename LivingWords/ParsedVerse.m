#import "ParsedVerse.h"

@implementation ParsedVerse

+ (instancetype)createFromUrlString:(NSString *)urlString
{
    ParsedVerse *parsedVerse = [ParsedVerse new];
    NSArray *components = [urlString componentsSeparatedByString:@"/"];
    parsedVerse.book = [components firstObject];
    parsedVerse.chapterStart = @([components[1] integerValue]);
    parsedVerse.numberStart = @([components[2] integerValue]);

    return parsedVerse;
}

- (NSString *)urlString
{
    return [NSString stringWithFormat:@"%@/%@/%@", self.book, self.chapterStart, self.numberStart];
}

@end
