#import "NewNoteViewController.h"
#import "Note.h"
#import "Verse.h"
#import "VerseFactory.h"

@interface NewNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
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
        newNote.text = [self.richTextEditor getHTML];

        NSOrderedSet *verseSet = [VerseFactory createWithText:self.verseTextField.text
                                         managedObjectContext:self.persistenceController.managedObjectContext];

        newNote.verses = verseSet;

        [self.persistenceController save];
    }];
}

@end
