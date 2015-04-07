#import <Kiwi/Kiwi.h>
#import "VerseParser.h"


SPEC_BEGIN(VerseParserSpec)

describe(@"VerseParser", ^{
    describe(@"+parseString:", ^{
        it(@"returns verse with parsed properties", ^{
            NSString *verseString = @"John 3:16";

            NSSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [[set allObjects] firstObject];

            [[expectFutureValue(result.book) shouldEventually] equal:@"John"];
            [[expectFutureValue(result.chapterStart) shouldEventually] equal:@3];
            [[expectFutureValue(result.numberStart) shouldEventually] equal:@16];
        });

        it(@"returns verse for numbered book", ^{
            NSString *verseString = @"1 John 3:16";

            NSSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [[set allObjects] firstObject];

            [[expectFutureValue(result.book) shouldEventually] equal:@"1 John"];
            [[expectFutureValue(result.chapterStart) shouldEventually] equal:@3];
            [[expectFutureValue(result.numberStart) shouldEventually] equal:@16];
        });

        it(@"returns verse for range of numbers", ^{
            NSString *verseString = @"1 John 3:16-17";

            NSSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [[set allObjects] firstObject];

            [[expectFutureValue(result.book) shouldEventually] equal:@"1 John"];
            [[expectFutureValue(result.chapterStart) shouldEventually] equal:@3];
            [[expectFutureValue(result.numberStart) shouldEventually] equal:@16];
            [[expectFutureValue(result.numberEnd) shouldEventually] equal:@17];
        });

        it(@"returns multiple verses", ^{
            NSString *verseString = @"1 John 3:16-17, John 3:16";

            NSSet *set = [VerseParser parseString:verseString];
            ParsedVerse *resultOne = [[set allObjects] firstObject];
            ParsedVerse *resultTwo = [[set allObjects] lastObject];

            [[expectFutureValue(resultOne.book) shouldEventually] equal:@"1 John"];
            [[expectFutureValue(resultOne.chapterStart) shouldEventually] equal:@3];
            [[expectFutureValue(resultOne.numberStart) shouldEventually] equal:@16];
            [[expectFutureValue(resultOne.numberEnd) shouldEventually] equal:@17];

            [[expectFutureValue(resultTwo.book) shouldEventually] equal:@"John"];
            [[expectFutureValue(resultTwo.chapterStart) shouldEventually] equal:@3];
            [[expectFutureValue(resultTwo.numberStart) shouldEventually] equal:@16];
        });
    });
});

SPEC_END
