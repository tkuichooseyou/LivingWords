#import <Kiwi/Kiwi.h>
#import <UIKit/UIKit.h>
#import "VerseParser.h"


SPEC_BEGIN(VerseParserSpec)

describe(@"VerseParser", ^{
    describe(@"+parseString:", ^{
        it(@"returns verse with parsed properties", ^{
            NSString *verseString = @"John 3:16";

            NSArray *parsedVerses = [VerseParser parseString:verseString];
            ParsedVerse *result = [parsedVerses firstObject];

            [[result.book should] equal:@"John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
            [[theValue(result.range.location) should] equal:theValue(0)];
            [[theValue(result.range.length) should] equal:theValue(verseString.length)];
        });

        it(@"returns verse for numbered book", ^{
            NSString *verseString = @"1 John 3:16";

            NSArray *parsedVerses = [VerseParser parseString:verseString];
            ParsedVerse *result = [parsedVerses firstObject];

            [[result.book should] equal:@"1 John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
        });

        it(@"returns verse for range of numbers", ^{
            NSString *verseString = @"1 John 3:16-17";

            NSArray *parsedVerses = [VerseParser parseString:verseString];
            ParsedVerse *result = [parsedVerses firstObject];

            [[result.book should] equal:@"1 John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
            [[result.numberEnd should] equal:@17];
        });

        it(@"returns multiple verses", ^{
            NSString *verseString = @"1 John 3:16-17, 1 Corinthians 3:16";

            NSArray *parsedVerses = [VerseParser parseString:verseString];
            ParsedVerse *resultOne = [parsedVerses firstObject];
            ParsedVerse *resultTwo = [parsedVerses lastObject];

            [[resultOne.book should] equal:@"1 John"];
            [[resultOne.chapterStart should] equal:@3];
            [[resultOne.numberStart should] equal:@16];
            [[resultOne.numberEnd should] equal:@17];

            [[resultTwo.book should] equal:@"1 Corinthians"];
            [[resultTwo.chapterStart should] equal:@3];
            [[resultTwo.numberStart should] equal:@16];
        });

        it(@"returns empty set if no verse is parsed", ^{
            NSString *verseString = @"something";
            NSArray *parsedVerses = [VerseParser parseString:verseString];
            [[parsedVerses should] beEmpty];
        });
    });

    describe(@"+displayVerse:", ^{
        it(@"returns formatted string for single verse", ^{
            NSManagedObjectContext *mockManagedObjectContext = [NSManagedObjectContext nullMock];
            NSEntityDescription *mockEntityDescription = [NSEntityDescription nullMock];
            [NSEntityDescription stub:@selector(entityForName:inManagedObjectContext:)
                            andReturn:mockEntityDescription
                        withArguments:@"Verse", mockManagedObjectContext];

            Verse *mockVerse = [Verse nullMock];
            [mockVerse stub:@selector(book) andReturn:@"John"];
            [mockVerse stub:@selector(chapterStart) andReturn:@3];
            [mockVerse stub:@selector(numberStart) andReturn:@16];

            NSString *result = [VerseParser displayVerse:mockVerse];

            [[result should] equal:@"John 3:16"];
        });
    });

    describe(@"+styleString:", ^{
        it(@"returns string with url attribute on verses", ^{
            NSString *input = @"I think John 3:16 is a good verse, and so is Romans 8:28";

            NSDictionary *attributesOne = @{ NSLinkAttributeName : @"John/3/16" };
            NSDictionary *attributesTwo = @{ NSLinkAttributeName : @"Romans/8/28" };
            NSMutableAttributedString *mutableExpected = [[NSMutableAttributedString alloc] initWithString:input];
            NSRange rangeOne = [input rangeOfString:@"John 3:16"];
            NSRange rangeTwo = [input rangeOfString:@"Romans 8:28"];
            [mutableExpected addAttributes:attributesOne range:rangeOne];
            [mutableExpected addAttributes:attributesTwo range:rangeTwo];
            NSAttributedString *expected = [mutableExpected copy];

            NSAttributedString *result = [VerseParser styleString:input];
            NSDictionary *expectedAttrsOne = [expected attributesAtIndex:rangeOne.location
                                                       effectiveRange:&rangeOne];
            NSDictionary *actualAttrsOne = [result attributesAtIndex:rangeOne.location
                                                   effectiveRange:&rangeOne];
            NSDictionary *expectedAttrsTwo = [expected attributesAtIndex:rangeTwo.location
                                                       effectiveRange:&rangeTwo];
            NSDictionary *actualAttrsTwo = [result attributesAtIndex:rangeTwo.location
                                                   effectiveRange:&rangeTwo];

            [[result.string should] equal:expected.string];
            [[actualAttrsOne should] equal:expectedAttrsOne];
            [[actualAttrsTwo should] equal:expectedAttrsTwo];
        });
    });
});

SPEC_END
