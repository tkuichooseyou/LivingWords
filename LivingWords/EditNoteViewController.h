#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"
#import "Note.h"

@interface EditNoteViewController : UIViewController
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (strong, readwrite) PersistenceController *persistenceController;
@property (strong, nonatomic) Note *note;

@end
