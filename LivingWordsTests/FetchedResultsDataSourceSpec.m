#import <Kiwi/Kiwi.h>
#import "FetchedResultsDataSource.h"


SPEC_BEGIN(FetchedResultsDataSourceSpec)

describe(@"FetchedResultsDataSource", ^{

//            __block NSFetchedResultsController *mockFetchedResultsController;
//            __block NSFetchRequest *mockFetchRequest;
//
//                mockFetchRequest = [NSFetchRequest nullMock];
//                [NSFetchRequest stub:@selector(alloc) andReturn:mockFetchRequest];
//                [mockFetchRequest stub:@selector(initWithEntityName:)
//                             andReturn:mockFetchRequest
//                         withArguments:@"Note"];
//
//                mockFetchedResultsController = [NSFetchedResultsController nullMock];
//                [NSFetchedResultsController stub:@selector(alloc) andReturn:mockFetchedResultsController];
//                [mockFetchedResultsController stub:@selector(initWithFetchRequest:managedObjectContext:sectionNameKeyPath:cacheName:)
//                                         andReturn:mockFetchedResultsController
//                                     withArguments:mockFetchRequest, mockManagedObjectContext, nil, nil];
//
//
//            it(@"sorts fetched results by date", ^{
//                NSSortDescriptor *mockSortDescriptor = [NSSortDescriptor nullMock];
//                [NSSortDescriptor stub:@selector(sortDescriptorWithKey:ascending:)
//                             andReturn:mockSortDescriptor
//                 withArguments:@"date", theValue(YES)];
//
//                [[mockFetchRequest should] receive:@selector(setSortDescriptors:)
//                                     withArguments:@[mockSortDescriptor]];
//
//                callback();
//            });
//
//            it(@"performs fetch for notes", ^{
//                [mockNotesVC stub:@selector(fetchedResultsController) andReturn:mockFetchedResultsController];
//                [[mockFetchedResultsController should] receive:@selector(performFetch:)];
//                callback();
//            });
//
});

SPEC_END
