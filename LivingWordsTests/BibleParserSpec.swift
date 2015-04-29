import Quick
import Nimble

class BibleParserSpec: QuickSpec {
    override func spec() {
        describe("BibleParser") {
            describe("textForParsedVerse:") {
                it("returns text for john 3:16 verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    parsedVerse.chapterStart = 3
                    parsedVerse.numberStart = 16
                    parsedVerse.chapterEnd = 3
                    parsedVerse.numberEnd = 16
                    let expected = "\"For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for genesis 1:5 verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "Genesis"
                    parsedVerse.chapterStart = 1
                    parsedVerse.numberStart = 5
                    parsedVerse.chapterEnd = 1
                    parsedVerse.numberEnd = 5
                    let expected = "God called the light Day, and the darkness he called Night. And there was evening and there was morning, the first day."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for first verse in a chapter") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "Genesis"
                    parsedVerse.chapterStart = 21
                    parsedVerse.numberStart = 1
                    parsedVerse.chapterEnd = 21
                    parsedVerse.numberEnd = 1
                    let expected = "The LORD visited Sarah as he had said, and the LORD did to Sarah as he had promised."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for range in john 3:16-18 verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    parsedVerse.chapterStart = 3
                    parsedVerse.numberStart = 16
                    parsedVerse.chapterEnd = 3
                    parsedVerse.numberEnd = 18
                    let expected = "\"For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life. For God did not send his Son into the world to condemn the world, but in order that the world might be saved through him. Whoever believes in him is not condemned, but whoever does not believe is condemned already, because he has not believed in the name of the only Son of God."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }
            }
        }
    }
}
