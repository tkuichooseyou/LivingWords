#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Verse : NSManagedObject

@property (nonatomic, retain) NSString * book;
@property (nonatomic, retain) NSNumber * chapterStart;
@property (nonatomic, retain) NSNumber * numberStart;
@property (nonatomic, retain) NSNumber * numberEnd;
@property (nonatomic, retain) NSNumber * chapterEnd;
@property (nonatomic, retain) NSSet *notes;
@end

@interface Verse (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
