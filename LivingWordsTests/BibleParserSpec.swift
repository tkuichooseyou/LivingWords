import Quick
import Nimble

class BibleParserSpec: QuickSpec {
    override func spec() {
        describe("BibleParser") {
            describe("textForParsedVerse:") {
                it("returns text for verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    parsedVerse.chapterStart = 3
                    parsedVerse.numberStart = 16
                    let expected = "For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life."

                    expect(BibleParser.textForParsedVerse(parsedVerse)) == expected
                }
            }
        }
    }
}
