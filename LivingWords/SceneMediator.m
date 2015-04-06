#import <UIKit/UIKit.h>
#import "SceneMediator.h"
#import "NewNoteViewController.h"
#import "NotesViewController.h"

@implementation SceneMediator
- (void)segueWithIdentifier:(NSString *)identifier segue:(UIStoryboardSegue *)segue
{
    NSLog(@"Transitioning From %@ to %@", segue.sourceViewController, segue.destinationViewController);

    if ([identifier isEqualToString:@"NewNoteViewController"])
    {
        NewNoteViewController *newNoteVC = (NewNoteViewController *)segue.destinationViewController;

        newNoteVC.sceneMediator = self;
        newNoteVC.persistenceController = [(NotesViewController *)segue.sourceViewController persistenceController];
    }
//    else if ([identifier isEqualToString:@"FromBToC"])
//    {
//        ViewControllerC *destinationVC = (ViewControllerC *)segue.destinationViewController;
//
//        destinationVC.sceneMediator = self;
//    }
}

@end
