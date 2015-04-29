#import "ParsedVerse.h"

@implementation ParsedVerse

+ (instancetype)createFromUrlString:(NSString *)urlString
{
    ParsedVerse *parsedVerse = [ParsedVerse new];
    NSArray *components = [urlString componentsSeparatedByString:@"/"];
    parsedVerse.book = [components firstObject];
    parsedVerse.chapterStart = @([components[1] integerValue]);
    parsedVerse.numberStart = @([components[2] integerValue]);
    parsedVerse.chapterEnd = @([components[3] integerValue]);
    parsedVerse.numberEnd = @([components[4] integerValue]);

    return parsedVerse;
}

- (NSString *)urlString
{
    return [NSString stringWithFormat:@"%@/%@/%@/%@/%@",
            self.book, self.chapterStart, self.numberStart, self.chapterEnd, self.numberEnd];
}

- (NSString *)displayFormatted
{
    if ([self.chapterStart integerValue] != [self.chapterEnd integerValue]) {
        return [NSString stringWithFormat:@"%@ %@:%@-%@:%@",
            self.book, self.chapterStart, self.numberStart, self.chapterEnd, self.numberEnd];
    } else if ([self.numberStart integerValue] != [self.numberEnd integerValue]) {
        return [NSString stringWithFormat:@"%@ %@:%@-%@",
            self.book, self.chapterStart, self.numberStart, self.numberEnd];
    }
    return [NSString stringWithFormat:@"%@ %@:%@",
            self.book, self.chapterStart, self.numberStart];
}

@end
