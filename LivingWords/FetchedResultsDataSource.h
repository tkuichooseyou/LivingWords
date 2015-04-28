#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FetchedResultsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                   tableView:(UITableView *)tableView
                                fetchRequest:(NSFetchRequest *)fetchRequest;

@end
