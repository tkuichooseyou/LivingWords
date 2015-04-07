#import "VerseFactory.h"

@implementation VerseFactory

+ (NSSet *)createWithText:(NSString *)text managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSEntityDescription *verseEntityDescription = [NSEntityDescription entityForName:@"Verse"
                                                              inManagedObjectContext:managedObjectContext];
    Verse *newVerse = [[Verse alloc] initWithEntity:verseEntityDescription
                     insertIntoManagedObjectContext:managedObjectContext];
    
    newVerse.book = text;
//    newVerse.chapterStart = text;
//    newVerse.numberStart = text;
    return [NSSet setWithObject:newVerse];
}

@end
