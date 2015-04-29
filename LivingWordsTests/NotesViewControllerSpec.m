#import <Kiwi/Kiwi.h>
#import "NotesViewController.h"


@interface NotesViewController ()
- (void)fetchWithDateAscending:(BOOL)ascending;
@end

SPEC_BEGIN(NotesViewControllerSpec)

describe(@"NotesViewController", ^{
    __block NotesViewController *notesVC;

    beforeEach(^{
        notesVC = [NotesViewController new];
    });

    describe(@"fetchWithDateAscending:", ^{
        __block FetchedResultsDataSource *mockFetchedResultsDataSource;
        __block NSFetchRequest *mockFetchRequest;
        __block UITableView *mockTableView;

        beforeEach(^{
            mockFetchRequest = [NSFetchRequest nullMock];
            [NSFetchRequest stub:@selector(alloc)
                       andReturn:mockFetchRequest];
            [mockFetchRequest stub:@selector(initWithEntityName:)
                         andReturn:mockFetchRequest
                     withArguments:@"Note"];

            PersistenceController *mockPersistenceController = [PersistenceController nullMock];
            NSManagedObjectContext *mockManagedObjectContext = [NSManagedObjectContext nullMock];
            [mockPersistenceController stub:@selector(managedObjectContext) andReturn:mockManagedObjectContext];
            [notesVC stub:@selector(persistenceController) andReturn:mockPersistenceController];

            mockTableView = [UITableView nullMock];
            [notesVC stub:@selector(tableView) andReturn:mockTableView];

            mockFetchedResultsDataSource = [FetchedResultsDataSource nullMock];
            [FetchedResultsDataSource stub:@selector(alloc) andReturn:mockFetchedResultsDataSource];
            [mockFetchedResultsDataSource stub:@selector(initWithManagedObjectContext:tableView:fetchRequest:)
                                     andReturn:mockFetchedResultsDataSource
                                 withArguments:mockManagedObjectContext, mockTableView, mockFetchRequest];
        });

        it(@"sorts by date", ^{
            [[mockFetchRequest should] receive:@selector(setSortDescriptors:)
                                 withArguments:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];

            [notesVC fetchWithDateAscending:YES];
        });

        it(@"sets fetched results data source", ^{
            [[notesVC should] receive:@selector(setFetchedResultsDataSource:)
                        withArguments:mockFetchedResultsDataSource];

            [notesVC fetchWithDateAscending:YES];
        });

        it(@"sets tableView delegate to fetched results data source", ^{
            [[mockTableView should] receive:@selector(setDelegate:)
                              withArguments:mockFetchedResultsDataSource];

            [notesVC fetchWithDateAscending:YES];
        });

        it(@"sets tableView data source to fetched results data source", ^{
            [[mockTableView should] receive:@selector(setDataSource:)
                              withArguments:mockFetchedResultsDataSource];

            [notesVC fetchWithDateAscending:YES];
        });

        it(@"reloads data on tableView", ^{
            [[mockTableView should] receive:@selector(reloadData)];

            [notesVC fetchWithDateAscending:YES];
        });
    });
});

SPEC_END
