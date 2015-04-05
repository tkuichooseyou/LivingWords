#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"

@interface NotesViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (strong, readwrite) PersistenceController *persistenceController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
