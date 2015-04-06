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
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) NSSet *verses;
@end