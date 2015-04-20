#import <Kiwi/Kiwi.h>
#import "ParsedVerse.h"


SPEC_BEGIN(ParsedVerseSpec)

describe(@"ParsedVerse", ^{
    __block ParsedVerse *parsedVerse;

    beforeEach(^{
        parsedVerse = [ParsedVerse new];
        parsedVerse.book = @"John";
        parsedVerse.chapterStart = @3;
        parsedVerse.numberStart = @16;
    });

    describe(@"createFromUrlString:", ^{
        it(@"creates verse from url string", ^{
            ParsedVerse *result = [ParsedVerse createFromUrlString:@"John/3/16"];
            [[result.book should] equal:@"John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
        });
    });

    describe(@"urlString:", ^{
        it(@"returns string with properties", ^{
            [[[parsedVerse urlString] should] equal:@"John/3/16"];
        });
    });
});

SPEC_END
