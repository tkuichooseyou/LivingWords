#import <UIKit/UIKit.h>
#import "FetchedResultsDataSource.h"
#import "NoteCell.h"
#import "FetchedResultsController+DelegateForTableView.h"

@implementation FetchedResultsDataSource

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                   tableView:(UITableView *)tableView
{
    self = [super init];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:fetchRequest
                                                            managedObjectContext:managedObjectContext
                                                            sectionNameKeyPath:nil
                                                            cacheName:nil];
    fetchedResultsController.tableView = tableView;
    self.fetchedResultsController = fetchedResultsController;

    fetchedResultsController.delegate = fetchedResultsController;

    NSError *error = nil;
    [fetchedResultsController performFetch:&error];

    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NoteCell";
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                     forIndexPath:indexPath];
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureForNote:note];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (record) {
            [self.fetchedResultsController.managedObjectContext deleteObject:record];
        }
    }
}

@end
