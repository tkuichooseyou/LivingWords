#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^InitCallbackBlock)(void);

@interface PersistenceController : NSObject

@property (strong, readonly) NSManagedObjectContext *managedObjectContext;
- (id)initWithCallback:(InitCallbackBlock)callback;
- (void)save;

@end
