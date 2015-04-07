#import <Kiwi/Kiwi.h>
#import "VerseFactory.h"


SPEC_BEGIN(VerseFactorySpec)

describe(@"VerseFactory", ^{
    describe(@"+createWithText:managedObjectContext", ^{
        xit(@"returns set with single verse with parsed properties", ^{
            NSManagedObjectContext *mockManagedObjectContext = [NSManagedObjectContext nullMock];
            NSString *verseString = @"John 3:16";

            NSSet *set = [VerseFactory createWithText:verseString managedObjectContext:mockManagedObjectContext];
            Verse *result = [[set allObjects] firstObject];

            [[result.book should] equal:@"John"];
            [[result.chapterStart should] equal:@"3"];
            [[result.numberStart should] equal:@"16"];
        });
    });
});

SPEC_END
