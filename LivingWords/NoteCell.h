#import <UIKit/UIKit.h>

@interface NoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
