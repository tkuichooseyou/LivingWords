#import <ReactiveCocoa/ReactiveCocoa.h>
#import <UIKit/UIKit.h>
#import "VerseParser.h"
#import "Bible.h"

@implementation VerseParser

+ (NSArray *)parseString:(NSString *)string
{
    NSError *error = NULL;
    NSString *bibleBooks = [[Bible books] componentsJoinedByString:@"|"];
    NSString *regexString = [NSString stringWithFormat:@"(%@)\\.?\\s*(\\d{1,3})[\\p{Pd}\\p{Zs}:]*(\\d{1,3})?[\\p{Pd}\\p{Zs}:]*(\\d{1,3})?",
                             bibleBooks];
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexString
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    if (error) {
        NSLog(@"error with VerseParser parseString regex: %@", error);
        return @[];
    }

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

+ (NSAttributedString *)styleString:(NSString *)text
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text
                                                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];

    NSArray *parsedVerses = [VerseParser parseString:text];

    for (ParsedVerse *parsedVerse in parsedVerses) {
        [string addAttributes:@{NSLinkAttributeName : [parsedVerse urlString]} range:parsedVerse.range];
    };
    return [string copy];
}

#pragma mark - private

typedef ParsedVerse *(^verseMatcher)(NSTextCheckingResult *);

+ (verseMatcher)verseMatcherFromString:(NSString *)string {

    return ^ParsedVerse *(NSTextCheckingResult *match) {
        ParsedVerse *verse = [ParsedVerse new];
        NSRange bookRange = [match rangeAtIndex:1];
        NSRange chapterRange = [match rangeAtIndex:2];
        NSRange numberStartRange = [match rangeAtIndex:3];
        if (bookRange.location == NSIntegerMax | chapterRange.location == NSIntegerMax | numberStartRange.location == NSIntegerMax) {
            return nil;
        }

        verse.book = [string substringWithRange:bookRange];
        verse.chapterStart = @([[string substringWithRange:chapterRange] integerValue]);
//    TODO: real chapter end
        verse.chapterEnd = @([[string substringWithRange:chapterRange] integerValue]);
        verse.numberStart = @([[string substringWithRange:numberStartRange] integerValue]);
        verse.range = match.range;

        if ([match rangeAtIndex:4].location != NSNotFound) {
            NSRange numberEndRange = [match rangeAtIndex:4];
            verse.numberEnd = @([[string substringWithRange:numberEndRange] integerValue]);
        } else {
            verse.numberEnd = verse.numberStart;
        }
        return verse;
    };
}

@end
