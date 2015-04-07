#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EditNoteViewController.h"
#import "Verse.h"

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
    self.verseTextField.text = [(Verse *)[[self.note.verses allObjects] firstObject] book];
    self.textTextView.text = self.note.text;

    RAC(self, note.title) = self.titleTextField.rac_textSignal;
    RAC(self, note.location) = self.locationTextField.rac_textSignal;
    RAC(self, note.speaker) = self.speakerTextField.rac_textSignal;
    RAC(self, note.text) = self.textTextView.rac_textSignal;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

@end
