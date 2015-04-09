#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag, Verse;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * collection;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * key_takeaways;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * speaker;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSData * attributedText;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) NSOrderedSet *verses;
@end

@interface Note (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

- (void)insertObject:(Verse *)value inVersesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromVersesAtIndex:(NSUInteger)idx;
- (void)insertVerses:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeVersesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInVersesAtIndex:(NSUInteger)idx withObject:(Verse *)value;
- (void)replaceVersesAtIndexes:(NSIndexSet *)indexes withVerses:(NSArray *)values;
- (void)addVersesObject:(Verse *)value;
- (void)removeVersesObject:(Verse *)value;
- (void)addVerses:(NSOrderedSet *)values;
- (void)removeVerses:(NSOrderedSet *)values;
@end
