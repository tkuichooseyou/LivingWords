#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EditNoteViewController.h"
#import "Verse.h"
#import "VerseParser.h"

@interface EditNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;


@end

@implementation EditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleTextField.text = self.note.title;
    [self.richTextEditor setHTML:self.note.text];

    RAC(self.note, title) = self.titleTextField.rac_textSignal;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.note.text = [self.richTextEditor getHTML];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

@end
