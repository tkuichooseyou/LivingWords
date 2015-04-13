#import "NotesViewController.h"
#import "NoteCell.h"
#import "Note.h"

@implementation NotesViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedNote = [self.fetchedResultsDataSource.fetchedResultsController objectAtIndexPath:indexPath];
    [self.sceneMediator segueWithIdentifier:segue.identifier segue:segue];
}

@end
