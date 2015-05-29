#import "NotesViewController.h"
#import "NoteCell.h"
#import "Note.h"

@interface NotesViewController ()

@property (nonatomic) BOOL ascending;
@property (weak, nonatomic) IBOutlet UIButton *dateSortButton;

@end

@implementation NotesViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.selectedNote = [self.fetchedResultsDataSource.fetchedResultsController objectAtIndexPath:indexPath];
    } else {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note"
                                                             inManagedObjectContext:self.persistenceController.managedObjectContext];
        Note *newNote = [[Note alloc] initWithEntity:entityDescription
                      insertIntoManagedObjectContext:self.persistenceController.managedObjectContext];
        self.selectedNote = newNote;
    }
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

- (IBAction)sort:(id)sender {
    self.ascending = self.ascending ? NO : YES;
}

- (void)setPersistenceController:(PersistenceController *)persistenceController {
    _persistenceController = persistenceController;
    self.ascending = NO;
}

- (void)setAscending:(BOOL)ascending {
    _ascending = ascending;
    if (ascending) {
        [self.dateSortButton setTitle:@"⌃" forState:UIControlStateNormal];
    } else {
        [self.dateSortButton setTitle:@"⌄" forState:UIControlStateNormal];
    }
    [self fetchWithDateAscending:ascending];
}

- (void)fetchWithDateAscending:(BOOL)ascending {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:ascending]]];
    FetchedResultsDataSource *fetchedResultsDataSource = [[FetchedResultsDataSource alloc] initWithManagedObjectContext:self.persistenceController.managedObjectContext
                                                                                                              tableView:self.tableView
                                                                                                           fetchRequest:fetchRequest];

    self.fetchedResultsDataSource = fetchedResultsDataSource;
    self.tableView.delegate = fetchedResultsDataSource;
    self.tableView.dataSource = fetchedResultsDataSource;
    [self.tableView reloadData];
}

@end
