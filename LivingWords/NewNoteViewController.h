#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"

@interface NewNoteViewController : UIViewController
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (strong, readwrite) PersistenceController *persistenceController;

@end

