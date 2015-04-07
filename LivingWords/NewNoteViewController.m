#import "NewNoteViewController.h"
#import "Note.h"
#import "Verse.h"

@interface NewNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@end

@implementation NewNoteViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                             inManagedObjectContext:self.persistenceController.managedObjectContext];
        Note *newNote = [[Note alloc] initWithEntity:entityDescription
                      insertIntoManagedObjectContext:self.persistenceController.managedObjectContext];

        newNote.title = self.titleTextField.text;
        newNote.location = self.locationTextField.text;
        newNote.speaker = self.speakerTextField.text;
        newNote.text = self.textTextView.text;

        NSEntityDescription *verseEntityDescription = [NSEntityDescription entityForName:@"Verse"
                                                                  inManagedObjectContext:self.persistenceController.managedObjectContext];
        Verse *newVerse = [[Verse alloc] initWithEntity:verseEntityDescription
                         insertIntoManagedObjectContext:self.persistenceController.managedObjectContext];

        newVerse.book = self.verseTextField.text;
        newVerse.chapterStart = @([self.verseTextField.text integerValue]);
        newVerse.numberStart = @([self.verseTextField.text integerValue]);
        NSSet *verseSet = [NSSet setWithObject:newVerse];
        newNote.verses = verseSet;

        [self.persistenceController save];
    }];
}

@end
