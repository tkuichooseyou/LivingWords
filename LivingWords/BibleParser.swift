class BibleParser: NSObject {
    class func textForContentModel(contentModel:KFEpubContentModel, epubPath:NSString, parsedVerse:ParsedVerse) -> String {
        let (contentFile, verseID) = contentFileFromContentModel(contentModel, parsedVerse:parsedVerse)

        let path = String(format:"%@/%@", epubPath, contentFile)
        let data:NSData? = NSData(contentsOfFile:path)
        let doc:TFHpple = TFHpple(HTMLData:data)
        let xpathQueryOne = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following::span[@class='verse-num' and text()=\(parsedVerse.numberStart)]/following::span[@class='woc']"
        let xpathQueryTwo = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following::span[@class='verse-num' and text()=\(parsedVerse.numberStart)]/following-sibling::text()"
        var elements:NSArray = doc.searchWithXPathQuery(xpathQueryOne)
        if elements.count == 0 {
            elements = doc.searchWithXPathQuery(xpathQueryTwo)
            return elements.firstObject!.content
        }
        if let element:TFHppleElement = elements.firstObject as? TFHppleElement {
            let textNodes = element.children.filter { $0.isTextNode() }
            return textNodes
                .map{ $0.content }
                .reduce("", combine: +)
        }
        return ""
    }

    class func contentFileFromContentModel(contentModel:KFEpubContentModel, parsedVerse:ParsedVerse) -> (String, String) {
        let chapterAndNumberStart = String(format:"%03d%03d",
            parsedVerse.chapterStart.integerValue,
            parsedVerse.numberStart.integerValue)

        let spineIndex = spineIndexFromSpine(contentModel.spine, parsedVerse:parsedVerse)
        let something = contentModel.spine[spineIndex] as! String
        let contentFile = (contentModel.manifest[something] as! NSDictionary)["href"] as! String

        let tempString = split(contentFile, isSeparator:{$0 == "."}).first!
        let index: String.Index = advance(tempString.startIndex, 6)
        let verseID = String(format:"v%@%@", tempString.substringFromIndex(index), chapterAndNumberStart)
        return (contentFile, verseID)
    }

    class func spineIndexFromSpine(spine:[AnyObject], parsedVerse:ParsedVerse) -> Int {
        let searchString = String(format:"%@.text", parsedVerse.book)

        if let spine = spine as? [String] {
            let key = spine.filter { string in
                return string.rangeOfString(searchString) != nil
            }
            return find(spine, key.first!)!
        }
        return 4;
    }
}
