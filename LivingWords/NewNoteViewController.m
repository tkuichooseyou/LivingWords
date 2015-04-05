#import "NewNoteViewController.h"

@interface NewNoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *speakerTextField;
@property (weak, nonatomic) IBOutlet UITextField *verseTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@end

@implementation NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancel:(id)sender {
}

- (IBAction)save:(id)sender {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                         inManagedObjectContext:self.persistenceController.managedObjectContext];
    NSManagedObject *newNote = [[NSManagedObject alloc] initWithEntity:entityDescription
                                        insertIntoManagedObjectContext:self.persistenceController.managedObjectContext];

    [newNote setValue:self.titleTextField.text forKey:@"title"];
    [newNote setValue:self.locationTextField.text forKey:@"location"];
    [newNote setValue:self.speakerTextField.text forKey:@"speaker"];
    [newNote setValue:self.textTextView.text forKey:@"text"];

    NSEntityDescription *verseEntityDescription = [NSEntityDescription entityForName:@"Verse"
                                                         inManagedObjectContext:self.persistenceController.managedObjectContext];
    NSManagedObject *newVerse = [[NSManagedObject alloc] initWithEntity:verseEntityDescription
                                        insertIntoManagedObjectContext:self.persistenceController.managedObjectContext];

    [newVerse setValue:self.verseTextField.text forKey:@"book"];
    [newVerse setValue:self.verseTextField.text forKey:@"chapter"];
    [newVerse setValue:self.verseTextField.text forKey:@"number"];
    NSSet *verseSet = [NSSet setWithObject:newVerse];
    [newNote setValue:verseSet forKey:@"verses"];

    [self.persistenceController save];
}

@end
