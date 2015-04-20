#import <Foundation/Foundation.h>

@interface ParsedVerse : NSObject
@property (nonatomic, strong) NSString *book;
@property (nonatomic, strong) NSNumber *chapterStart;
@property (nonatomic, strong) NSNumber *chapterEnd;
@property (nonatomic, strong) NSNumber *numberStart;
@property (nonatomic, strong) NSNumber *numberEnd;
@property (nonatomic) NSRange range;

+ (instancetype)createFromUrlString:(NSString *)urlString;
- (NSString *)urlString;
- (NSString *)displayFormatted;
@end
