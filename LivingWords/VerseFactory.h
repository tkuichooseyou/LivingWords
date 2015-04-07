#import <Foundation/Foundation.h>
#import "Verse.h"


@interface VerseFactory : NSObject
+ (NSSet *)createWithText:(NSString *)text managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
