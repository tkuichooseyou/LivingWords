#import <Kiwi/Kiwi.h>
#import "VerseFactory.h"


SPEC_BEGIN(VerseFactorySpec)

describe(@"VerseFactory", ^{
    describe(@"+createWithText:managedObjectContext", ^{
        it(@"returns set with single verse with parsed properties", ^{
            NSManagedObjectContext *mockManagedObjectContext = [NSManagedObjectContext nullMock];
            NSEntityDescription *mockEntityDescription = [NSEntityDescription nullMock];
            [NSEntityDescription stub:@selector(entityForName:inManagedObjectContext:)
                            andReturn:mockEntityDescription
                        withArguments:@"Verse", mockManagedObjectContext];

            Verse *mockVerse = [Verse nullMock];
            [Verse stub:@selector(alloc) andReturn:mockVerse];
            [mockVerse stub:@selector(initWithEntity:insertIntoManagedObjectContext:)
                  andReturn:mockVerse
              withArguments:mockEntityDescription, mockManagedObjectContext];

            [[expectFutureValue(mockVerse) shouldEventually] receive:@selector(setBook:)
                                                       withArguments:@"John"];
            [[expectFutureValue(mockVerse) shouldEventually] receive:@selector(setChapterStart:)
                                                       withArguments:@3];
            [[expectFutureValue(mockVerse) shouldEventually] receive:@selector(setNumberStart:)
                                                       withArguments:@16];

            NSString *verseString = @"John 3:16";
            NSOrderedSet *expected = [NSOrderedSet orderedSetWithArray:@[mockVerse]];

            NSOrderedSet *result = [VerseFactory createWithText:verseString
                                        managedObjectContext:mockManagedObjectContext];

            [[expectFutureValue(result) shouldEventually] equal:expected];
        });
    });
});

SPEC_END
