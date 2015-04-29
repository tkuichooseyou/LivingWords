#import <Kiwi/Kiwi.h>
#import "AppDelegate.h"
#import "SceneMediator.h"
#import "NotesViewController.h"

@interface AppDelegate ()
@property (strong, readwrite) PersistenceController *persistenceController;
@property (nonatomic, strong) SceneMediator *sceneMediator;
@end

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;
    __block UIApplication *mockApplication;

    beforeEach(^{
        appDelegate = [AppDelegate new];
        mockApplication = [UIApplication nullMock];
    });

    describe(@"-application:didFinishLaunchingWithOptions:", ^{
        __block NSDictionary *mockOptions;
        __block PersistenceController *mockPersistenceController;
        beforeEach(^{
            mockOptions = [NSDictionary nullMock];
            mockPersistenceController = [PersistenceController nullMock];
            [PersistenceController stub:@selector(alloc)
                              andReturn:mockPersistenceController];
            [mockPersistenceController stub:@selector(initWithCallback:)
                                  andReturn:mockPersistenceController];
        });

        it(@"initializes persistence controller", ^{
            [[appDelegate should] receive:@selector(setPersistenceController:)
                            withArguments:mockPersistenceController];

            [appDelegate application:mockApplication didFinishLaunchingWithOptions:mockOptions];
        });

        it(@"sets scene mediator on self", ^{
            SceneMediator *mockSceneMediator = [SceneMediator nullMock];
            [SceneMediator stub:@selector(new) andReturn:mockSceneMediator];

            [[appDelegate should] receive:@selector(setSceneMediator:)
                            withArguments:mockSceneMediator];

            [appDelegate application:mockApplication didFinishLaunchingWithOptions:mockOptions];
        });

        context(@"when calling completeUserInterface callback", ^{
            __block void (^callback)();
            __block NotesViewController *mockNotesVC;
            __block SceneMediator *mockSceneMediator;
            __block NSManagedObjectContext *mockManagedObjectContext;
            __block UITableView *mockTableView;

            beforeEach(^{
                [mockPersistenceController stub:@selector(initWithCallback:) withBlock:^id(NSArray *params) {
                    callback = [params firstObject];
                    return nil;
                }];

                [appDelegate stub:@selector(persistenceController) andReturn:mockPersistenceController];

                UINavigationController *mockNavigationController = [UINavigationController nullMock];
                UIWindow *mockWindow = [UIWindow nullMock];
                [appDelegate stub:@selector(window) andReturn:mockWindow];
                [mockWindow stub:@selector(rootViewController) andReturn:mockNavigationController];
                mockNotesVC = [NotesViewController nullMock];
                [mockNavigationController stub:@selector(topViewController) andReturn:mockNotesVC];
                mockSceneMediator = [SceneMediator nullMock];
                [appDelegate stub:@selector(sceneMediator) andReturn:mockSceneMediator];

                mockTableView = [UITableView nullMock];
                [mockNotesVC stub:@selector(tableView) andReturn:mockTableView];

                mockManagedObjectContext = [NSManagedObjectContext nullMock];
                [mockPersistenceController stub:@selector(managedObjectContext) andReturn:mockManagedObjectContext];

                [appDelegate application:mockApplication didFinishLaunchingWithOptions:mockOptions];
            });

            it(@"sets scene mediator on initial view controller", ^{
                [[mockNotesVC should] receive:@selector(setSceneMediator:)
                                  withArguments:mockSceneMediator];

                callback();
            });

            it(@"injects persistence controller into initial view controller", ^{
                [[mockNotesVC should] receive:@selector(setPersistenceController:)
                                  withArguments:mockPersistenceController];

                callback();
            });
        });
    });

    context(@"persistence controller", ^{
        __block PersistenceController *mockPersistenceController;
        beforeEach(^{
            mockPersistenceController = [PersistenceController nullMock];
            [appDelegate stub:@selector(persistenceController) andReturn:mockPersistenceController];
        });

        describe(@"-applicationWillResignActive:", ^{
            it(@"lets persistence controller save", ^{
                [[mockPersistenceController should] receive:@selector(save)];
                [appDelegate applicationWillResignActive:[UIApplication nullMock]];
            });
        });

        describe(@"-applicationDidEnterBackground:", ^{
            it(@"lets persistence controller save", ^{
                [[mockPersistenceController should] receive:@selector(save)];
                [appDelegate applicationDidEnterBackground:[UIApplication nullMock]];
            });
        });

        describe(@"-applicationWillTerminate:", ^{
            it(@"lets persistence controller save", ^{
                [[mockPersistenceController should] receive:@selector(save)];
                [appDelegate applicationWillTerminate:[UIApplication nullMock]];
            });
        });
    });
});

SPEC_END
