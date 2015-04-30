#import "ShowVerseViewController.h"
#import "Bible.h"
#import "VerseParser.h"
#import "LivingWords-Swift.h"

@interface ShowVerseViewController ()

@property (nonatomic) NSUInteger spineIndex;
@property (strong, nonatomic) ParsedVerse *parsedVerse;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ShowVerseViewController

+ (instancetype) createWithStoryboard:(UIStoryboard *)storyboard parsedVerse:(ParsedVerse *)parsedVerse
{
    ShowVerseViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowVerseViewController"];
    vc.parsedVerse = parsedVerse;
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.spinner startAnimating];
    self.title = [self.parsedVerse displayFormatted];

    self.textView.text = [BibleParser textForParsedVerse:self.parsedVerse];
    [self.textView scrollRangeToVisible:NSMakeRange(0, 0)];
    [self.spinner stopAnimating];
    self.spinner.hidden=YES;
}

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
