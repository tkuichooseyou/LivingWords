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

@property (strong, nonatomic) NSArray *parsedVerses;

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

    RAC(self.note, title) = self.titleTextField.rac_textSignal;
    RAC(self.note, location) = self.locationTextField.rac_textSignal;
    RAC(self.note, speaker) = self.speakerTextField.rac_textSignal;
    RAC(self.note, text) = self.textTextView.rac_textSignal;
    RAC(self, parsedVerses) = [self.textTextView.rac_textSignal map:^NSArray *(NSString *text) {
        return [VerseParser parseString:text];
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

@end
