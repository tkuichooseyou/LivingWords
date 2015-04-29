#import <Kiwi/Kiwi.h>
#import "ParsedVerse.h"


SPEC_BEGIN(ParsedVerseSpec)

describe(@"ParsedVerse", ^{
    __block ParsedVerse *parsedVerse;

    describe(@"createFromUrlString:", ^{
        it(@"creates verse from url string", ^{
            ParsedVerse *result = [ParsedVerse createFromUrlString:@"John/3/16/3/18"];
            [[result.book should] equal:@"John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
            [[result.chapterEnd should] equal:@3];
            [[result.numberEnd should] equal:@18];
        });
    });

    describe(@"urlString:", ^{
        beforeEach(^{
            parsedVerse = [ParsedVerse new];
            parsedVerse.book = @"John";
            parsedVerse.chapterStart = @3;
            parsedVerse.numberStart = @16;
            parsedVerse.chapterEnd = @3;
            parsedVerse.numberEnd = @18;
        });

        it(@"returns string with properties", ^{
            [[[parsedVerse urlString] should] equal:@"John/3/16/3/18"];
        });
    });

    describe(@"displayFormatted", ^{
        it(@"displays single verse", ^{
            parsedVerse = [ParsedVerse new];
            parsedVerse.book = @"John";
            parsedVerse.chapterStart = @3;
            parsedVerse.numberStart = @16;
            parsedVerse.chapterEnd = @3;
            parsedVerse.numberEnd = @16;

            [[[parsedVerse displayFormatted] should] equal:@"John 3:16"];
        });

        it(@"displays verse range when chapter end is same as start", ^{
            parsedVerse = [ParsedVerse new];
            parsedVerse.book = @"John";
            parsedVerse.chapterStart = @3;
            parsedVerse.numberStart = @16;
            parsedVerse.chapterEnd = @3;
            parsedVerse.numberEnd = @18;

            [[[parsedVerse displayFormatted] should] equal:@"John 3:16-18"];
        });

        it(@"displays verse range when chapter end is not same as start", ^{
            parsedVerse = [ParsedVerse new];
            parsedVerse.book = @"John";
            parsedVerse.chapterStart = @3;
            parsedVerse.numberStart = @16;
            parsedVerse.chapterEnd = @4;
            parsedVerse.numberEnd = @18;

            [[[parsedVerse displayFormatted] should] equal:@"John 3:16-4:18"];
        });
    });
});

SPEC_END
