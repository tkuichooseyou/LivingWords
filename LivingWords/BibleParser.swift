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

        let verseRange = (verseStart...verseEnd)

        let patterns = (verseRange).map { verseNum -> String in
            let verseNumberStartPattern = "\"verse-num\">\(verseNum)</span>(?:\\s?<span>)?(.*?)<"
            let chapterStartPattern = "\"chapter-num\">\\s\(parsedVerse.chapterStart)\\s</span>"
            if verseNum == 1 {
                return chapterStartPattern + "(.*?)<"
            } else {
                return chapterStartPattern + "(?:.*?)" + verseNumberStartPattern
            }
        }

        if let bookPath = NSBundle.mainBundle().pathForResource(parsedVerse.book.lowercaseString, ofType: "html", inDirectory: "esv"),
            bookString = NSString(contentsOfFile: bookPath, encoding: NSUTF8StringEncoding, error: &error) as? String {
                return patterns
                    .map { self.matchesForRegexInText($0, text:bookString).first }
                    .reduce("", combine: {
                        if let y = $1 {return $0 + " " + y}
                        return errorMessage
                    })
                    .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        } else {
            println(error)
            return errorMessage
        }
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
