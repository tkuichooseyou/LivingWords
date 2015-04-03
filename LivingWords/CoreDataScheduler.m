#import <CoreData/CoreData.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CoreDataScheduler.h"

@interface CoreDataScheduler ()
@property (nonatomic) NSManagedObjectContext *context;
@end

@implementation CoreDataScheduler

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (!self) return nil;

    self.context = context;

    return self;
}

- (RACDisposable *)schedule:(void (^)(void))block
{
    NSParameterAssert(block);

    RACDisposable *disposable = [RACDisposable new];

    [self.context performBlock:^{
        if (disposable.disposed) {
            return;
        }

        block();
    }];

    return disposable;
}

@end
