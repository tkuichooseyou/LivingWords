#import "Note.h"
#import "Tag.h"
#import "Verse.h"


@implementation Note

@dynamic collection;
@dynamic date;
@dynamic key_takeaways;
@dynamic location;
@dynamic speaker;
@dynamic text;
@dynamic attributedText;
@dynamic title;
@dynamic tags;
@dynamic verses;

- (void) awakeFromInsert
{
    [super awakeFromInsert];
    self.date = [NSDate date];
}

@end
