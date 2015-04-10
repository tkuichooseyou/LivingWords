#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "PersistenceController.h"
#import "Note.h"
#import "RichTextEditor.h"

@interface EditNoteViewController : UIViewController
@property (nonatomic, strong) SceneMediator *sceneMediator;
@property (strong, readwrite) PersistenceController *persistenceController;
@property (strong, nonatomic) Note *note;
@property (strong, nonatomic) RichTextEditor *richTextEditor;

@end
