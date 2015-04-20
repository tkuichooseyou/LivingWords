#import <Foundation/Foundation.h>
#import <KFEpubKit/KFEpubKit.h>
#import "ParsedVerse.h"

@interface Bible : NSObject
+ (NSString *)contentFileFromContentModel:(KFEpubContentModel *)contentModel parsedVerse:(ParsedVerse *)parsedVerse;
+ (NSArray *)books;
@end
