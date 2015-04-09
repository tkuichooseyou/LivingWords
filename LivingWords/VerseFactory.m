#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VerseFactory.h"
#import "VerseParser.h"

@implementation VerseFactory

+ (NSOrderedSet *)createWithText:(NSString *)text managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSOrderedSet *parsedVerses = [NSOrderedSet orderedSetWithArray:[VerseParser parseString:text]];
    NSEntityDescription *verseEntityDescription = [NSEntityDescription entityForName:@"Verse"
                                                              inManagedObjectContext:managedObjectContext];

    RACSequence *versesSequence = [parsedVerses.rac_sequence map:^id(ParsedVerse *parsedVerse) {
        Verse *newVerse = [[Verse alloc] initWithEntity:verseEntityDescription
                         insertIntoManagedObjectContext:managedObjectContext];

        newVerse.book = parsedVerse.book;
        newVerse.chapterStart = parsedVerse.chapterStart;
        newVerse.chapterEnd = parsedVerse.chapterEnd;
        newVerse.numberStart = parsedVerse.numberStart;
        newVerse.numberEnd = parsedVerse.numberEnd;
        return newVerse;
    }];
    return [NSOrderedSet orderedSetWithArray:versesSequence.array];
}

@end
