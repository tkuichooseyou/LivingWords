#import <Foundation/Foundation.h>
#import "Verse.h"


@interface VerseFactory : NSObject
+ (NSOrderedSet *)createWithText:(NSString *)text managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
