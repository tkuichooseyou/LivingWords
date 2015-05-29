#import <Foundation/Foundation.h>
@class Verse;

@interface ParsedVerse : NSObject
@property (nonatomic, strong) NSString *book;
@property (nonatomic, strong) NSNumber *chapterStart;
@property (nonatomic, strong) NSNumber *chapterEnd;
@property (nonatomic, strong) NSNumber *numberStart;
@property (nonatomic, strong) NSNumber *numberEnd;
@property (nonatomic) NSRange range;

+ (instancetype)createFromUrlString:(NSString *)urlString;
+ (instancetype)createFromVerse:(Verse *)verse;
- (NSString *)urlString;
- (NSString *)bookFileString;
- (NSString *)displayFormatted;
@end
