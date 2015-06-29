import UIKit

public class BibleParser: NSObject {
    static let errorMessage = "Verse not found"

    public class func textForParsedVerse(parsedVerse:ParsedVerse) -> String {
        var error: NSError?
        let verseStart = parsedVerse.numberStart.integerValue
        let verseEnd = parsedVerse.numberEnd.integerValue
        if verseEnd < verseStart {
            return errorMessage
        }

        let chapterStartPattern = "<span (?:id=\"calibre_link-\\d+\" )?class=\"chapter-num\">\\s\(parsedVerse.chapterStart)\\s</span>"
        let numberEndBound = parsedVerse.numberEnd.integerValue + 1
        let chapterEndBound = parsedVerse.chapterStart.integerValue + 1
        let endBoundOne = "(?:<p (?:id=\"calibre_link-\\d+\" )?class=\"heading\".{1,50}<\\/p>.{1,50}?<span class=\"book-name\".+?</span><span (?:id=\"calibre_link-\\d+\" )?class=\"chapter-num\">\\s\(chapterEndBound)\\s</span>)"
        let endBoundTwo = "(?:<span (?:id=\"calibre_link-\\d+\" )?class=\"verse-num\">\(numberEndBound)</span>)"
        let endBound = "(?:" + endBoundOne + "|" +  endBoundTwo + ")"
        let normalCaptureGroup = "(<span (?:id=\"calibre_link-\\d+\" )?class=\"verse-num\">\(parsedVerse.numberStart)</span>(?:.*?)?)"

        let pattern = parsedVerse.numberStart == 1 ?
            "(" + chapterStartPattern + ".*?)" + endBound :
            chapterStartPattern + "(?:.*?)" + normalCaptureGroup + endBound

        if let bookPath = NSBundle.mainBundle().pathForResource(parsedVerse.bookFileString(), ofType: "html", inDirectory: "esv"),
            bookString = NSString(contentsOfFile: bookPath, encoding: NSUTF8StringEncoding, error: &error) as? String {
                if let htmlString = matchesForRegexInText(pattern, text: bookString).first,
                    htmlData = htmlString
                        .dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                    let options = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding] as [NSObject : AnyObject]
                    return NSAttributedString(data: htmlData, options: options, documentAttributes: nil, error: nil)?.string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                        ?? errorMessage
                }
        }
        println(error)
        return errorMessage
    }

    class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        var error: NSError?
        let regex = NSRegularExpression(
            pattern: regex,
            options: NSRegularExpressionOptions.DotMatchesLineSeparators,
            error: &error)!
        let nsString = text as NSString
        let results = regex.matchesInString(text,
            options: nil, range: NSMakeRange(0, nsString.length))
            as! [NSTextCheckingResult]
        return map(results) { nsString.substringWithRange($0.rangeAtIndex(1))}
    }
}
