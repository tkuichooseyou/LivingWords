#import "Verse.h"
#import "Note.h"


@implementation Verse

@dynamic book;
@dynamic chapterEnd;
@dynamic chapterStart;
@dynamic numberEnd;
@dynamic numberStart;
@dynamic notes;


- (NSString *)displayFormatted
{
    return [NSString stringWithFormat:@"%@ %@:%@",
            self.book, self.chapterStart, self.numberStart];
}

@end

