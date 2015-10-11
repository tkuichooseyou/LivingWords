#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PersistenceController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) PersistenceController *persistenceController;
- (void)refreshNotesTableView;

@end

