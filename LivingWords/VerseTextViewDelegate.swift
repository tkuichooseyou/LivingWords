import UIKit

class VerseTextViewDelegate: NSObject, UITextViewDelegate {
    let textView: UITextView
    let viewController: UIViewController

    init(textView: UITextView, viewController: UIViewController) {
        self.textView = textView
        self.viewController = viewController
    }

    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        if (!self.textView.editable) {
            let parsedVerse: ParsedVerse = ParsedVerse.createFromUrlString(URL.absoluteString)
            let showVerseVC: ShowVerseViewController  = ShowVerseViewController.createWithStoryboard(
                self.viewController.storyboard,
                parsedVerse:parsedVerse)

            if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
                self.viewController.navigationController?.pushViewController(showVerseVC, animated: true)
            } else {
                let showVersePopoverController = UIPopoverController(contentViewController: showVerseVC)
                showVersePopoverController.presentPopoverFromRect(CGRectMake(0, 0, 15, 15),
                    inView:self.viewController.view,
                    permittedArrowDirections:UIPopoverArrowDirection.Up,
                    animated:true)
            }
        }

        return false;
    }
}
