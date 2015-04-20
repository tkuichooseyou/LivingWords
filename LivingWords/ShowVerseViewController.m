#import <KFEpubKit/KFEpubKit.h>
#import "ShowVerseViewController.h"
#import "Bible.h"
#import "VerseParser.h"

@interface ShowVerseViewController () <KFEpubControllerDelegate>

@property (nonatomic, strong) KFEpubController *epubController;
@property (nonatomic, strong) KFEpubContentModel *contentModel;
@property (nonatomic) NSUInteger spineIndex;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) ParsedVerse *parsedVerse;

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

#pragma mark Epub Contents

- (void)updateContentForContentFile:(NSString *)contentFile
{
    NSURL *contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                              [self.epubController.epubContentBaseURL absoluteURL],
                                              contentFile]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:contentURL];
    [self.webView loadRequest:request];
}

#pragma mark KFEpubControllerDelegate Methods

- (void)epubController:(KFEpubController *)controller didOpenEpub:(KFEpubContentModel *)contentModel
{
    self.contentModel = contentModel;
    NSString *contentFile = [Bible contentFileFromContentModel:contentModel
                                                   parsedVerse:self.parsedVerse];
    [self updateContentForContentFile:contentFile];
}


- (void)epubController:(KFEpubController *)controller didFailWithError:(NSError *)error
{
    NSLog(@"epubController:didFailWithError: %@", error.description);
}


@end
