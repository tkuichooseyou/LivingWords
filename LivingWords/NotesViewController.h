#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"
#import "Note.h"
#import "FetchedResultsDataSource.h"

@interface NotesViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (nonatomic, strong, readwrite) PersistenceController *persistenceController;
@property (strong, nonatomic) Note *selectedNote;
@property (strong, nonatomic) FetchedResultsDataSource *fetchedResultsDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
