#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureForNote:(Note *)note;
@end
