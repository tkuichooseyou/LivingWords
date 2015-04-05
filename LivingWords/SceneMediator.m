#import <UIKit/UIKit.h>
#import "SceneMediator.h"

@implementation SceneMediator
- (void)segueWithIdentifier:(NSString *)identifier segue:(UIStoryboardSegue *)segue
{
    NSLog(@"Transitioning From %@ to %@", segue.sourceViewController, segue.destinationViewController);

    //Pass the mediator object to the destination view controller and take appropriate action depending on segue
//    if ([identifier isEqualToString:@"FromAToB"])
//    {
//        ViewControllerB *destinationVC = (ViewControllerB *)segue.destinationViewController;
//
//        destinationVC.sceneMediator = self;
//    }
//    else if ([identifier isEqualToString:@"FromBToC"])
//    {
//        ViewControllerC *destinationVC = (ViewControllerC *)segue.destinationViewController;
//
//        destinationVC.sceneMediator = self;
//    }
}

@end
