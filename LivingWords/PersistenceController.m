#import "PersistenceController.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface PersistenceController ()

@property (strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (strong) NSManagedObjectContext *privateContext;
@property (copy) InitCallbackBlock initCallback;

- (void)initializeCoreData;

@end

@implementation PersistenceController

- (id)initWithCallback:(InitCallbackBlock)callback;
{
    if (!(self = [super init])) return nil;

    self.initCallback = callback;
    [self initializeCoreData];

    return self;
}

- (void)initializeCoreData
{
    if ([self managedObjectContext]) return;

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LivingWords" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    ZAssert(mom, @"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));

    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    ZAssert(coordinator, @"Failed to initialize coordinator");

    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

    self.privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.privateContext.persistentStoreCoordinator = coordinator;
    self.managedObjectContext.parentContext = self.privateContext;
    [self registerForiCloudNotifications];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSPersistentStoreCoordinator *psc = [self.privateContext persistentStoreCoordinator];
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
        options[NSInferMappingModelAutomaticallyOption] = @YES;
        options[NSSQLitePragmasOption] = @{ @"journal_mode":@"DELETE" };

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"LivingWords.sqlite"];

        NSError *error = nil;

        NSMutableDictionary *localOptions = [options mutableCopy];
        [localOptions addEntriesFromDictionary:[self localStoreOptions]];
        NSPersistentStore *localPersistenceStore = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                                     configuration:nil
                                                                               URL:storeURL
                                                                           options:localOptions error:&error];

        [options addEntriesFromDictionary:[self iCloudPersistentStoreOptions]];

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [queue addOperationWithBlock:^{
            NSError *error = nil;
            if (localPersistenceStore) {
                NSPersistentStore *iCloudStore = [psc migratePersistentStore:localPersistenceStore
                                                                       toURL:storeURL
                                                                     options:options
                                                                    withType:NSSQLiteStoreType error:&error];

                ZAssert(iCloudStore,
                        @"Error initializing iCloudStore: %@\n%@", [error localizedDescription], [error userInfo]);
                [psc removePersistentStore:iCloudStore error:nil];
            }

            [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:storeURL
                                    options:options
                                      error:nil];

            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{

                if (![self initCallback]) return;
                [self initCallback]();
            }];
        }];
    });
}

- (void)save
{
    if (![self.privateContext hasChanges] && ![[self managedObjectContext] hasChanges]) return;

    [[self managedObjectContext] performBlockAndWait:^{
        NSError *error = nil;

        ZAssert([[self managedObjectContext] save:&error],
                @"Failed to save main context: %@\n%@",
                [error localizedDescription],
                [error userInfo]);

        [self.privateContext performBlock:^{
            NSError *privateError = nil;
            ZAssert([self.privateContext save:&privateError],
                    @"Error saving private context: %@\n%@",
                    [privateError localizedDescription],
                    [privateError userInfo]);
        }];
    }];
}

#pragma mark - Notification Observers
- (void)registerForiCloudNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter addObserver:self
                           selector:@selector(storesWillChange:)
                               name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                             object:self.privateContext.persistentStoreCoordinator];

    [notificationCenter addObserver:self
                           selector:@selector(storesDidChange:)
                               name:NSPersistentStoreCoordinatorStoresDidChangeNotification
                             object:self.privateContext.persistentStoreCoordinator];

    [notificationCenter addObserver:self
                           selector:@selector(persistentStoreDidImportUbiquitousContentChanges:)
                               name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                             object:self.privateContext.persistentStoreCoordinator];
}

# pragma mark - iCloud Support

- (NSDictionary *)localStoreOptions {
    return @{NSReadOnlyPersistentStoreOption: @YES};
}

- (NSDictionary *)iCloudPersistentStoreOptions {
    return @{NSPersistentStoreUbiquitousContentNameKey: @"livingwordsStore"};
}

- (void) persistentStoreDidImportUbiquitousContentChanges:(NSNotification *)changeNotification {
    NSManagedObjectContext *context = self.managedObjectContext;

    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:changeNotification];
    }];
}

- (void)storesWillChange:(NSNotification *)notification {
    NSManagedObjectContext *context = self.managedObjectContext;

    [context performBlockAndWait:^{
        NSError *error;

        if ([context hasChanges]) {
            BOOL success = [context save:&error];

            if (!success && error) {
                NSLog(@"%@",[error localizedDescription]);
            }
        }

        [context reset];
    }];

    [(AppDelegate *)[[UIApplication sharedApplication] delegate] refreshNotesTableView];
}

- (void)storesDidChange:(NSNotification *)notification {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] refreshNotesTableView];
}

@end
