#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "NewNoteViewController.h"
#import "NotesViewController.h"
#import "EditNoteViewController.h"

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
    }
}

@end
