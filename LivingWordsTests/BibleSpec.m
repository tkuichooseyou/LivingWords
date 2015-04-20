#import <Kiwi/Kiwi.h>
#import "Bible.h"

@interface Bible ()
+ (NSInteger)spineIndexFromSpine:(NSArray *)spine parsedVerse:(ParsedVerse *)parsedVerse;
@end

SPEC_BEGIN(BibleSpec)

describe(@"Bible", ^{

    describe(@"contentFileFromContentModel:parsedVerse", ^{
        xit(@"returns spine index of matching verse", ^{
            NSArray *spine = @[
                               @"b42.00.John.main",
                               @"b43.00.John.text",
                               @"b43.01.John.text"
                               ];
            NSString *verseLocation = @"#v43003016";
            ParsedVerse *parsedVerse = [ParsedVerse nullMock];
            [parsedVerse stub:@selector(book) andReturn:@"John"];
            KFEpubContentModel *mockContentModel = [KFEpubContentModel nullMock];

            NSString *result = [Bible contentFileFromContentModel:mockContentModel parsedVerse:parsedVerse];

            [[result should] equal:verseLocation];
        });
    });

    describe(@"spineIndexFromSpine:parsedVerse", ^{
        it(@"returns spine index of matching verse", ^{
            NSArray *spine = @[
                               @"b42.00.John.main",
                               @"b43.00.John.text",
                               @"b43.01.John.text"
                               ];
            ParsedVerse *parsedVerse = [ParsedVerse nullMock];
            [parsedVerse stub:@selector(book) andReturn:@"John"];

            NSInteger result = [Bible spineIndexFromSpine:spine parsedVerse:parsedVerse];

            [[theValue(result) should] equal:theValue(1)];
        });
    });

});

SPEC_END
