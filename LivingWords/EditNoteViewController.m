#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EditNoteViewController.h"
#import "Verse.h"
#import "VerseParser.h"
#import "ShowVerseViewController.h"

@interface EditNoteViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@property (nonatomic) BOOL editing;
@end

@implementation EditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleTextField.text = self.note.title;
    self.locationTextField.text = self.note.location;
    self.speakerTextField.text = self.note.speaker;
    self.verseTextField.text = [VerseParser displayVerse:[self.note.verses firstObject]];
    self.textTextView.text = self.note.text;

    self.textTextView.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor blueColor] };
    self.textTextView.delegate = self;
    self.editing = NO;

    RAC(self.note, title) = self.titleTextField.rac_textSignal;
    RAC(self.note, location) = self.locationTextField.rac_textSignal;
    RAC(self.note, speaker) = self.speakerTextField.rac_textSignal;
    RAC(self.note, text) = self.textTextView.rac_textSignal;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if (!self.textTextView.editable) {
        NSLog(@"Tapped!");
        ShowVerseViewController *showVerseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowVerseViewController"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            [self presentViewController:showVerseVC animated:YES completion:nil];
        } else {
        UIPopoverController *showVersePopoverController = [[UIPopoverController alloc] initWithContentViewController:showVerseVC];
        [showVersePopoverController presentPopoverFromRect:CGRectMake(0, 0, 15, 15)
                                                    inView:self.view
                                  permittedArrowDirections:UIPopoverArrowDirectionUp
                                                  animated:YES];
        }
    }

    return NO;
}

- (IBAction)rightBarButtonItemTapped:(id)sender
{
    self.editing = self.editing ? NO : YES;
}

- (void)setEditing:(BOOL)editing
{
    _editing = editing;
    self.textTextView.editable = editing;

    if (editing) {
        self.navigationItem.rightBarButtonItem.title = @"Save";
        [self.textTextView becomeFirstResponder];
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        [self.textTextView setAttributedText:[VerseParser styleString:self.textTextView.text]];
    }
}

@end
