#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Bible.h"

@implementation Bible

+ (NSString *)contentFileFromContentModel:(KFEpubContentModel *)contentModel parsedVerse:(ParsedVerse *)parsedVerse
{
    NSInteger spineIndex = [self spineIndexFromSpine:contentModel.spine parsedVerse:parsedVerse];
    NSString *contentFile = contentModel.manifest[contentModel.spine[spineIndex]][@"href"];

//    NSString *chapterAndNumberStart = [NSString stringWithFormat:@"%03d%03d",
//                              [parsedVerse.chapterStart intValue],
//                              [parsedVerse.numberStart intValue]
//                              ];
//    NSString *tempString = [[contentFile componentsSeparatedByString:@"."] firstObject];
//    NSString *bookNumber = [tempString substringFromIndex:[tempString rangeOfString:@"Text/b"].length];
//    NSString *verseLocation = [NSString stringWithFormat:@"%@%@",
//                               bookNumber,
//                               chapterAndNumberStart
//                               ];
//    return [NSString stringWithFormat:@"%@#v%@", contentFile, verseLocation];
    return contentFile;
}

+ (NSInteger)spineIndexFromSpine:(NSArray *)spine parsedVerse:(ParsedVerse *)parsedVerse
{
    NSString *searchString = [NSString stringWithFormat:@"%@.text", parsedVerse.book];
    NSString *key = [[[[spine rac_sequence] filter:^BOOL(NSString *string) {
        return [string rangeOfString:searchString].location != NSNotFound;
    }] array] firstObject];

    return [spine indexOfObject:key];
}

+ (NSArray *)books
{
    return @[
             @"Genesis",
             @"Exodus",
             @"Leviticus",
             @"Numbers",
             @"Deuteronomy",
             @"Joshua",
             @"Judges",
             @"Ruth",
             @"1 Samuel",
             @"2 Samuel",
             @"1 Kings",
             @"2 Kings",
             @"1 Chronicles",
             @"2 Chronicles",
             @"Ezra",
             @"Nehemiah",
             @"Tobit",
             @"Judith",
             @"Esther",
             @"1 Maccabees",
             @"2 Maccabees",
             @"Job",
             @"Psalms",
             @"Proverbs",
             @"Ecclesiastes",
             @"Song of Songs",
             @"Wisdom",
             @"Sirach",
             @"Isaiah",
             @"Jeremiah",
             @"Lamentations",
             @"Baruch",
             @"Ezekiel",
             @"Daniel",
             @"Hosea",
             @"Joel",
             @"Amos",
             @"Obadiah",
             @"Jonah",
             @"Micah",
             @"Nahum",
             @"Habakkuk",
             @"Zephaniah",
             @"Haggai",
             @"Zechariah",
             @"Malachi",
             @"Matthew",
             @"Mark",
             @"Luke",
             @"John",
             @"Acts",
             @"Romans",
             @"1 Corinthians",
             @"2 Corinthians",
             @"Galatians",
             @"Ephesians",
             @"Philippians",
             @"Colossians",
             @"1 Thessalonians",
             @"2 Thessalonians",
             @"1 Timothy",
             @"2 Timothy",
             @"Titus",
             @"Philemon",
             @"Hebrews",
             @"James",
             @"1 Peter",
             @"2 Peter",
             @"1 John",
             @"2 John",
             @"3 John",
             @"Jude",
             @"Revelation"
             ];
}

@end
