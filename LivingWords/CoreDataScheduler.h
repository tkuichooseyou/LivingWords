#import <Foundation/Foundation.h>

@interface CoreDataScheduler : NSObject

- (instancetype)initWithContext:(NSManagedObjectContext *)context;
- (RACDisposable *)schedule:(void (^)(void))block;

@end
