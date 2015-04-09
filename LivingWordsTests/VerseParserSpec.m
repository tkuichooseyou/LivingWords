#import <Kiwi/Kiwi.h>
#import "VerseParser.h"


SPEC_BEGIN(VerseParserSpec)

describe(@"VerseParser", ^{
    describe(@"+parseString:", ^{
        it(@"returns verse with parsed properties", ^{
            NSString *verseString = @"John 3:16";

            NSOrderedSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [set firstObject];

            [[result.book should] equal:@"John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
        });

        it(@"returns verse for numbered book", ^{
            NSString *verseString = @"1 John 3:16";

            NSOrderedSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [set firstObject];

            [[result.book should] equal:@"1 John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
        });

        it(@"returns verse for range of numbers", ^{
            NSString *verseString = @"1 John 3:16-17";

            NSOrderedSet *set = [VerseParser parseString:verseString];
            ParsedVerse *result = [set firstObject];

            [[result.book should] equal:@"1 John"];
            [[result.chapterStart should] equal:@3];
            [[result.numberStart should] equal:@16];
            [[result.numberEnd should] equal:@17];
        });

        it(@"returns multiple verses", ^{
            NSString *verseString = @"1 John 3:16-17, John 3:16";

            NSOrderedSet *set = [VerseParser parseString:verseString];
            ParsedVerse *resultOne = [set firstObject];
            ParsedVerse *resultTwo = [set lastObject];

            [[resultOne.book should] equal:@"1 John"];
            [[resultOne.chapterStart should] equal:@3];
            [[resultOne.numberStart should] equal:@16];
            [[resultOne.numberEnd should] equal:@17];

            [[resultTwo.book should] equal:@"John"];
            [[resultTwo.chapterStart should] equal:@3];
            [[resultTwo.numberStart should] equal:@16];
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
});

SPEC_END
