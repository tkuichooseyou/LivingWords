#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"
#import "RichTextEditor.h"

@interface NewNoteViewController : UIViewController
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (strong, readwrite) PersistenceController *persistenceController;
@property (strong, nonatomic) RichTextEditor *richTextEditor;

@end

