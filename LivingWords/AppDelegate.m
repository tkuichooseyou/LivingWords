#import "AppDelegate.h"
#import "SceneMediator.h"
#import "NotesViewController.h"

@interface AppDelegate ()
@property (strong, readwrite) PersistenceController *persistenceController;
@property (nonatomic, strong) SceneMediator *sceneMediator;

- (void)completeUserInterface;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.sceneMediator = [SceneMediator new];
    self.persistenceController = [[PersistenceController alloc] initWithCallback:^{
        [self completeUserInterface];
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.persistenceController save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.persistenceController save];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.persistenceController save];
}

- (void)completeUserInterface
{
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    NotesViewController *controller = (NotesViewController *)navigationController.topViewController;
    controller.sceneMediator = self.sceneMediator;
    controller.persistenceController = self.persistenceController;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    controller.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:self.persistenceController.managedObjectContext
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
    [controller.fetchedResultsController setDelegate:controller];

    NSError *error = nil;
    [controller.fetchedResultsController performFetch:&error];
    [controller.tableView reloadData];

    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
