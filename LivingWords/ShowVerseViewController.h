#import <UIKit/UIKit.h>
#import "ParsedVerse.h"

@interface ShowVerseViewController : UIViewController
+ (instancetype) createWithStoryboard:(UIStoryboard *)storyboard parsedVerse:(ParsedVerse *)parsedVerse;
@end
