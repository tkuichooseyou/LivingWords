#import "VerseTextDelegate.h"
#import "ParsedVerse.h"
#import "ShowVerseViewController.h"

@implementation VerseTextDelegate

- (instancetype)initWithTextView:(UITextView *)textView viewController:(UIViewController *)viewController {
    self = [super init];
    self.textView = textView;
    self.viewController = viewController;
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if (!self.textView.editable) {
        ParsedVerse *parsedVerse = [ParsedVerse createFromUrlString:[URL absoluteString]];
        ShowVerseViewController *showVerseVC = [ShowVerseViewController createWithStoryboard:self.viewController.storyboard
                                                                                 parsedVerse:parsedVerse];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self.viewController presentViewController:showVerseVC animated:YES completion:nil];
        } else {
        UIPopoverController *showVersePopoverController = [[UIPopoverController alloc] initWithContentViewController:showVerseVC];
        [showVersePopoverController presentPopoverFromRect:CGRectMake(0, 0, 15, 15)
                                                    inView:self.viewController.view
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
        }
    }

    return NO;
}

@end
