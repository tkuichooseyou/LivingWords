#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VerseParser.h"
#import "Bible.h"

@implementation VerseParser

+ (NSArray *)parseString:(NSString *)string
{
    NSError *error = NULL;
    NSString *bibleBooks = [[Bible books] componentsJoinedByString:@"|"];
    NSString *regexString = [NSString stringWithFormat:@"(%@)\\.?\\s*(\\d+)?[\\p{Pd}\\p{Zs}:]*(\\d+)?[\\p{Pd}\\p{Zs}:]*(\\d+)?",
                             bibleBooks];
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexString
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];

    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, string.length)];

    RACSequence *versesSequence = [matches.rac_sequence map:[self verseMatcherFromString:string]];

    return versesSequence.array;
}

+ (NSString *)displayVerse:(Verse *)verse
{
    return [NSString stringWithFormat:@"%@ %@:%@",
            verse.book, verse.chapterStart, verse.numberStart];
}

#pragma mark - private

typedef ParsedVerse *(^verseMatcher)(NSTextCheckingResult *);

+ (verseMatcher)verseMatcherFromString:(NSString *)string {

    return ^ParsedVerse *(NSTextCheckingResult *match) {
        ParsedVerse *verse = [ParsedVerse new];
        NSRange bookRange = [match rangeAtIndex:1];
        NSRange chapterRange = [match rangeAtIndex:2];
        NSRange numberStartRange = [match rangeAtIndex:3];

        verse.book = [string substringWithRange:bookRange];
        verse.chapterStart = @([[string substringWithRange:chapterRange] integerValue]);
        verse.numberStart = @([[string substringWithRange:numberStartRange] integerValue]);
        verse.range = match.range;

        if ([match rangeAtIndex:4].location != NSNotFound) {
            NSRange numberEndRange = [match rangeAtIndex:4];
            verse.numberEnd = @([[string substringWithRange:numberEndRange] integerValue]);
        }
        return verse;
    };
}

@end
