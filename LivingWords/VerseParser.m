#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VerseParser.h"
#import "Bible.h"

@implementation VerseParser

+ (NSOrderedSet *)parseString:(NSString *)string
{
    NSError *error = NULL;
    NSString *regexString = @"(\\d\\s\\p{L}+|\\p{L}+)\\.?\\s*(\\d+)?[\\p{Pd}\\p{Zs}:]*(\\d+)?[\\p{Pd}\\p{Zs}:]*(\\d+)?";
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexString
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];

    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, string.length)];

    RACSequence *versesSequence = [matches.rac_sequence map:^ParsedVerse *(NSTextCheckingResult *match) {
        NSRange bookRange = [match rangeAtIndex:1];
        NSRange chapterRange = [match rangeAtIndex:2];
        NSRange numberStartRange = [match rangeAtIndex:3];

        ParsedVerse *verse = [ParsedVerse new];
        verse.book = [string substringWithRange:bookRange];
        verse.chapterStart = @([[string substringWithRange:chapterRange] integerValue]);
        verse.numberStart = @([[string substringWithRange:numberStartRange] integerValue]);

        if ([match rangeAtIndex:4].location != NSNotFound) {
            NSRange numberEndRange = [match rangeAtIndex:4];
            verse.numberEnd = @([[string substringWithRange:numberEndRange] integerValue]);
        }
        return verse;
    }];

    return [NSOrderedSet orderedSetWithArray:versesSequence.array];
}

+ (NSString *)displayVerse:(Verse *)verse
{
    return [NSString stringWithFormat:@"%@ %@:%@",
            verse.book, verse.chapterStart, verse.numberStart];
}

@end
