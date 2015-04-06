#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Verse : NSManagedObject

@property (nonatomic, retain) NSString * book;
@property (nonatomic, retain) NSString * chapter;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSSet *notes;
@end
