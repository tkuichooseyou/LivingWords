#import "NoteCell.h"

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
}

@end
