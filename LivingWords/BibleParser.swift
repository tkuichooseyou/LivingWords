import UIKit

public class BibleParser: NSObject {
    public class func textForParsedVerse(parsedVerse:ParsedVerse) -> String {
        var error: NSError?
        let chapterStartPattern = "\"chapter-num\">\\s\(parsedVerse.chapterStart)\\s</span>"
        let verseNumberStartPattern = "\"verse-num\">\(parsedVerse.numberStart)</span>(?:\\s?<span>)?(.*?)<"
        let pattern = parsedVerse.numberStart == 1 ?
            chapterStartPattern + "(.*?)<" :
            chapterStartPattern + "(?:.*?)" + verseNumberStartPattern

        if let bookPath = NSBundle.mainBundle().pathForResource(parsedVerse.book.lowercaseString, ofType: "html", inDirectory: "esv"),
            let bookString = NSString(contentsOfFile: bookPath, encoding: NSUTF8StringEncoding, error: &error) as? String,
            let match = matchesForRegexInText(pattern, text:bookString).first {
                return match.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }

        return ""
    }

    class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        let regex = NSRegularExpression(
            pattern: regex,
            options: NSRegularExpressionOptions.DotMatchesLineSeparators,
            error: nil)!
        let nsString = text as NSString
        let results = regex.matchesInString(text,
            options: nil, range: NSMakeRange(0, nsString.length))
            as! [NSTextCheckingResult]
        return map(results) { nsString.substringWithRange($0.rangeAtIndex(1))}
    }
}
