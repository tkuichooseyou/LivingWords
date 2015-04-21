#import <KFEpubKit/KFEpubKit.h>
#import <hpple/TFHpple.h>
#import "ShowVerseViewController.h"
#import "Bible.h"
#import "VerseParser.h"
#import "LivingWords-Swift.h"

@interface ShowVerseViewController () <KFEpubControllerDelegate>

@property (nonatomic, strong) KFEpubController *epubController;
@property (nonatomic, strong) KFEpubContentModel *contentModel;
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
    NSURL *epubURL = [[NSBundle mainBundle] URLForResource:@"esv_classic_reference_bible" withExtension:@"epub"];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    self.epubController = [[KFEpubController alloc] initWithEpubURL:epubURL andDestinationFolder:documentsURL];
    self.epubController.delegate = self;
    [self.epubController openAsynchronous:YES];
}

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark KFEpubControllerDelegate Methods

- (void)epubController:(KFEpubController *)controller didFailWithError:(NSError *)error
{
    NSLog(@"epubController:didFailWithError: %@", error.description);
}

- (void)epubController:(KFEpubController *)controller didOpenEpub:(KFEpubContentModel *)contentModel
{
    self.textView.text = [BibleParser textForContentModel:contentModel
                                                 epubPath:[self.epubController.epubContentBaseURL relativePath]
                                              parsedVerse:self.parsedVerse];
    [self.spinner stopAnimating];
    self.spinner.hidden=YES;
}

@end
