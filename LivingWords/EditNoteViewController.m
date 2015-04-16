#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EditNoteViewController.h"
#import "Verse.h"
#import "VerseParser.h"

@interface EditNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@end

@implementation EditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleTextField.text = self.note.title;
    self.locationTextField.text = self.note.location;
    self.speakerTextField.text = self.note.speaker;
    self.verseTextField.text = [VerseParser displayVerse:[self.note.verses firstObject]];

    NSError *error;
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData:self.note.attributedText
                                                                          options:@{NSDocumentTypeDocumentAttribute: NSRTFDTextDocumentType,
                                                                                    NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                               documentAttributes:nil error:&error];
    self.textTextView.attributedText = attributedText;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(textTapped:)];
    [self.textTextView addGestureRecognizer:tapGestureRecognizer];
    

    RAC(self.note, title) = self.titleTextField.rac_textSignal;
    RAC(self.note, location) = self.locationTextField.rac_textSignal;
    RAC(self.note, speaker) = self.speakerTextField.rac_textSignal;
    RAC(self.note, text) = self.textTextView.rac_textSignal;

    @weakify(self)
    [self.textTextView.rac_textSignal subscribeNext:^(NSString *text) {
        @strongify(self)
        [self.textTextView setAttributedText:[VerseParser styleString:text]];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.note.attributedText = [self.textTextView.attributedText dataFromRange:NSMakeRange(0, self.textTextView.attributedText.length)
                                                            documentAttributes:@{NSDocumentTypeDocumentAttribute: NSRTFDTextDocumentType,
                                                                                 NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]}
                                                                         error:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

- (void)textTapped:(UITapGestureRecognizer *)recognizer
{
    UITextView *textView = (UITextView *)recognizer.view;

    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.top;

    NSUInteger characterIndex = [layoutManager characterIndexForPoint:location
                                                      inTextContainer:textView.textContainer
                             fractionOfDistanceBetweenInsertionPoints:NULL];

    if (characterIndex < textView.textStorage.length) {

        NSRange range;
        NSNumber *value = [textView.attributedText attribute:@"verse" atIndex:characterIndex effectiveRange:&range];
        if ([value isEqual:@(YES)]) {
            NSLog(@"Tapped!");
        }
    }
}

- (IBAction)rightBarButtonItemTapped:(id)sender {
    self.textTextView.userInteractionEnabled = !self.textTextView.userInteractionEnabled;
}

@end
