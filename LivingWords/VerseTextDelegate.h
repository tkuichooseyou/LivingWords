#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VerseTextDelegate : NSObject <UITextViewDelegate>
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIViewController *viewController;
- (instancetype)initWithTextView:(UITextView *)textView viewController:(UIViewController *)viewController;
@end
