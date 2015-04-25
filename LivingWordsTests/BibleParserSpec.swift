import Quick
import Nimble

class BibleParserSpec: QuickSpec {
    override func spec() {
        describe("BibleParser") {
            describe("textForParsedVerse:") {
                it("returns text for verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    expect(BibleParser.textForParsedVerse(parsedVerse)) == "For God so loved the world"
                }
            }
        }
    }
}
