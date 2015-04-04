#import "AppDelegate.h"
#import "NewNoteViewController.h"
#import "SceneMediator.h"

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
    NewNoteViewController *controller = (NewNoteViewController *)navigationController.topViewController;
    controller.sceneMediator = self.sceneMediator;
    controller.persistenceController = self.persistenceController;
}

@end
