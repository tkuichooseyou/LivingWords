#import "NoteCell.h"
#import "Verse.h"

@interface NoteCell ()
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation NoteCell

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.dateStyle = NSDateFormatterShortStyle;
    return self;
}

- (void)configureForNote:(Note *)note
{
    self.dateLabel.text = [self.dateFormatter stringFromDate:note.date];
    self.titleLabel.text = note.title;
    self.verseLabel.text = [(Verse *)[note.verses firstObject] displayFormatted];
    self.speakerLabel.text = [NSString stringWithFormat:@"- %@", note.speaker ?: @"" ];
    self.locationLabel.text = note.location;
}

@end
