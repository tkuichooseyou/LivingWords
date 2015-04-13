#import <objc/runtime.h>
#import "FetchedResultsController+DelegateForTableView.h"
#import "NoteCell.h"

@implementation NSFetchedResultsController (DelegateForTableView)
@dynamic tableView;

- (void)setTableView:(UITableView *)tableView {
    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITableView *)tableView {
    return objc_getAssociatedObject(self, @selector(tableView));
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            Note *note = [controller objectAtIndexPath:indexPath];
            NoteCell *cell = (NoteCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureForNote:note];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

@end
