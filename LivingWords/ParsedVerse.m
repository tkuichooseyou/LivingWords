#import "ParsedVerse.h"
#import "Verse.h"

@implementation ParsedVerse

+ (instancetype)createFromUrlString:(NSString *)urlString
{
    ParsedVerse *parsedVerse = [ParsedVerse new];
    NSArray *components = [urlString componentsSeparatedByString:@"/"];
    parsedVerse.book = [[components firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    parsedVerse.chapterStart = @([components[1] integerValue]);
    parsedVerse.numberStart = @([components[2] integerValue]);
    parsedVerse.chapterEnd = @([components[3] integerValue]);
    parsedVerse.numberEnd = @([components[4] integerValue]);

    return parsedVerse;
}

+ (instancetype)createFromVerse:(Verse *)verse
{
    ParsedVerse *parsedVerse = [ParsedVerse new];
    parsedVerse.book = [verse book];
    parsedVerse.chapterStart = [verse chapterStart];
    parsedVerse.numberStart = [verse numberStart];
    parsedVerse.chapterEnd = [verse chapterEnd];
    parsedVerse.numberEnd = [verse numberEnd];
    return parsedVerse;
}

- (NSString *)bookFileString {
    return [self.book.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)urlString
{
    return [NSString stringWithFormat:@"%@/%@/%@/%@/%@",
            [self.book stringByReplacingOccurrencesOfString:@" " withString:@"_"],
            self.chapterStart, self.numberStart, self.chapterEnd, self.numberEnd];
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
