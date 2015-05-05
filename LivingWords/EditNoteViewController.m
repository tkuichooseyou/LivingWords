#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACDelegateProxy.h>
#import "EditNoteViewController.h"
#import "Verse.h"
#import "VerseParser.h"
#import "ShowVerseViewController.h"
#import "LivingWords-Swift.h"

@interface EditNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;
@property (strong, nonatomic) id textViewDelegate;
@property (nonatomic) BOOL editing;
@end

@implementation EditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleTextField.text = self.note.title;
    self.locationTextField.text = self.note.location;
    self.speakerTextField.text = self.note.speaker;
    if (self.note.verses.count >= 1) {
        self.verseTextField.text = [VerseParser displayVerse:[self.note.verses firstObject]];
    }
    self.textTextView.text = self.note.text;

    self.textTextView.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor blueColor] };
    [self configureTextViewDelegate];
    self.editing = self.textTextView.editable;

    RAC(self.note, title) = self.titleTextField.rac_textSignal;
    RAC(self.note, location) = self.locationTextField.rac_textSignal;
    RAC(self.note, speaker) = self.speakerTextField.rac_textSignal;
    RAC(self.note, text) = self.textTextView.rac_textSignal;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
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
        self.textTextView.attributedText = [[NSAttributedString alloc] initWithString:self.textTextView.text];
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        self.textTextView.attributedText = [VerseParser styleString:self.textTextView.text];
    }
}

- (void)configureTextViewDelegate {
    self.textViewDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextViewDelegate)];
    @weakify(self)
    [[self.textViewDelegate rac_signalForSelector:@selector(textView:shouldInteractWithURL:inRange:)
                                     fromProtocol:@protocol(UITextViewDelegate)]
     subscribeNext:^(RACTuple *arguments) {
         @strongify(self)
         VerseTextViewDelegate *verseTextViewDelegate = [[VerseTextViewDelegate alloc] initWithTextView:self.textTextView
                                                                                         viewController:self];
         [verseTextViewDelegate textView:arguments.first shouldInteractWithURL:arguments.second inRange:NSMakeRange(0, 0)];
     }];
    self.textTextView.delegate = self.textViewDelegate;
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)sender
{
    self.activeField = nil;
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
