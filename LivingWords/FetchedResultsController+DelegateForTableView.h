#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (DelegateForTableView) <NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) UITableView *tableView;
@end