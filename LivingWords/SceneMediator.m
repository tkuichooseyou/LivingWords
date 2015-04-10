#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SceneMediator.h"
#import "NewNoteViewController.h"
#import "NotesViewController.h"
#import "EditNoteViewController.h"
#import "RichTextEditor.h"

@implementation SceneMediator
- (void)segueWithIdentifier:(NSString *)identifier segue:(UIStoryboardSegue *)segue
{
    if ([identifier isEqualToString:@"NewNoteViewController"]) {
        NewNoteViewController *newNoteVC = (NewNoteViewController *)segue.destinationViewController;
        newNoteVC.sceneMediator = self;
        newNoteVC.persistenceController = [(NotesViewController *)segue.sourceViewController persistenceController];
    } else if ([identifier isEqualToString:@"EditNoteViewController"]) {
        EditNoteViewController *destinationVC = (EditNoteViewController *)segue.destinationViewController;
        destinationVC.sceneMediator = self;
        destinationVC.persistenceController = [(NotesViewController *)segue.sourceViewController persistenceController];
        NotesViewController *notesVC = (NotesViewController *) segue.sourceViewController;
        destinationVC.note = notesVC.selectedNote;
        notesVC.selectedNote = nil;
    } else if ([identifier isEqualToString:@"NewNoteViewControllerToRichTextEditor"]) {
        RichTextEditor *richTextEditor = (RichTextEditor *)segue.destinationViewController;
        NewNoteViewController *newNoteVC = (NewNoteViewController *) segue.sourceViewController;
        newNoteVC.richTextEditor = richTextEditor;
    } else if ([identifier isEqualToString:@"EditNoteViewControllerToRichTextEditor"]) {
        RichTextEditor *richTextEditor = (RichTextEditor *)segue.destinationViewController;
        EditNoteViewController *editNoteVC = (EditNoteViewController *) segue.sourceViewController;
        editNoteVC.richTextEditor = richTextEditor;
    }
}

@end
