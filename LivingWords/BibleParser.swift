
public class BibleParser: NSObject {
    public class func textForParsedVerse(parsedVerse:ParsedVerse) -> String {
//    NSURL *epubURL = [[NSBundle mainBundle] URLForResource:@"esv_classic_reference_bible" withExtension:@"epub"];
//    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        return ""
//        return contentFiles
//            .map { String(format:"%@/%@", epubPath, $0) }
//            .map { NSData(contentsOfFile:$0) }
//            .map {
//                NSAttributedString(data:$0!,
//                    options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//                    documentAttributes:nil,
//                    error:nil)!.string
//            }
//            .map { self.textFromDoc($0, parsedVerse: parsedVerse) }
//            .reduce("", combine: +)
    }

//    class func contentFileFromContentModel(contentModel:KFEpubContentModel, parsedVerse:ParsedVerse) -> ([String], String) {
//        let chapterAndNumberStart = String(format:"%03d%03d",
//            parsedVerse.chapterStart.integerValue,
//            parsedVerse.numberStart.integerValue)
//
//        let spineIndexes = spineIndexesFromSpine(contentModel.spine, parsedVerse:parsedVerse)
//        let manifestKeys = spineIndexes.map { contentModel.spine[$0] as! String }
//        let contentFiles = manifestKeys.map { (contentModel.manifest[$0] as! NSDictionary)["href"] as! String }
//
//        let tempString = split(contentFiles.first!, isSeparator:{$0 == "."}).first!
//        let index: String.Index = advance(tempString.startIndex, 6)
//        let verseID = String(format:"v%@%@", tempString.substringFromIndex(index), chapterAndNumberStart)
//        return (contentFiles, verseID)
//    }
//
//    class func spineIndexesFromSpine(spine:[AnyObject], parsedVerse:ParsedVerse) -> [Int] {
//        let searchString = String(format:"%@.text", parsedVerse.book)
//
//        if let spine = spine as? [String] {
//            let keys = spine.filter { string in
//                return string.rangeOfString(searchString) != nil
//            }
//            return keys.map {find(spine, $0)!}
//        }
//        return [4];
//    }
//
//    private class func textFromDoc(doc:String, parsedVerse:ParsedVerse) -> String {
//        let searchString =  parsedVerse.numberStart == 1 ?
//            "\(parsedVerse.book) \(parsedVerse.chapterStart)(.*)\(Int(parsedVerse.numberStart) + 1)"
//            : "\(parsedVerse.book) \(parsedVerse.chapterStart).*\(parsedVerse.numberStart)(.*)\(Int(parsedVerse.numberStart) + 1)"
//
//        if let matchRange = doc.rangeOfString(".*", options: .RegularExpressionSearch) {
//            return doc.substringWithRange(matchRange)
//        }
//
//        return doc
//    }
}
