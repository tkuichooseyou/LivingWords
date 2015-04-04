#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong, readwrite) PersistenceController *persistenceController;
- (void)completeUserInterface;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
}

@end
