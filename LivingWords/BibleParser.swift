class BibleParser: NSObject {
    class func textForContentModel(contentModel:KFEpubContentModel, epubPath:NSString, parsedVerse:ParsedVerse) -> String {
        let (contentFiles, verseID) = contentFileFromContentModel(contentModel, parsedVerse:parsedVerse)

        return contentFiles
            .map { String(format:"%@/%@", epubPath, $0) }
            .map { NSData(contentsOfFile:$0) }
            .map { TFHpple(HTMLData:$0) }
            .map { self.textFromDoc($0, parsedVerse: parsedVerse) }
            .reduce("", combine: +)
    }

    class func contentFileFromContentModel(contentModel:KFEpubContentModel, parsedVerse:ParsedVerse) -> ([String], String) {
        let chapterAndNumberStart = String(format:"%03d%03d",
            parsedVerse.chapterStart.integerValue,
            parsedVerse.numberStart.integerValue)

        let spineIndexes = spineIndexesFromSpine(contentModel.spine, parsedVerse:parsedVerse)
        let manifestKeys = spineIndexes.map { contentModel.spine[$0] as! String }
        let contentFiles = manifestKeys.map { (contentModel.manifest[$0] as! NSDictionary)["href"] as! String }

        let tempString = split(contentFiles.first!, isSeparator:{$0 == "."}).first!
        let index: String.Index = advance(tempString.startIndex, 6)
        let verseID = String(format:"v%@%@", tempString.substringFromIndex(index), chapterAndNumberStart)
        return (contentFiles, verseID)
    }

    class func spineIndexesFromSpine(spine:[AnyObject], parsedVerse:ParsedVerse) -> [Int] {
        let searchString = String(format:"%@.text", parsedVerse.book)

        if let spine = spine as? [String] {
            let keys = spine.filter { string in
                return string.rangeOfString(searchString) != nil
            }
            return keys.map {find(spine, $0)!}
        }
        return [4];
    }

    private class func textFromDoc(doc:TFHpple, parsedVerse:ParsedVerse) -> String {
        var xpathQueryOne = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following::span[@class='verse-num' and text()=\(parsedVerse.numberStart)]/following::span[@class='woc']"
        var xpathQueryTwo = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following::span[@class='verse-num' and text()=\(parsedVerse.numberStart)]/following-sibling::text()"

        if parsedVerse.numberStart == 1 {
            xpathQueryOne = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following::span[@class='woc']"
            xpathQueryTwo = "//span[@class='chapter-num' and text()=\(parsedVerse.chapterStart)]/following-sibling::text()"
        }

        var elements:NSArray = doc.searchWithXPathQuery(xpathQueryOne)
        if elements.count == 0 {
            elements = doc.searchWithXPathQuery(xpathQueryTwo)
            if let element: TFHppleElement = elements.firstObject as? TFHppleElement {
                return element.content
            }
        }
        if let element:TFHppleElement = elements.firstObject as? TFHppleElement {
            let textNodes = element.children.filter { $0.isTextNode() }
            return textNodes
                .map{ $0.content }
                .reduce("", combine: +)
        }

        return ""
//        return "Verse not found for \(parsedVerse.displayFormatted())"
    }
}
