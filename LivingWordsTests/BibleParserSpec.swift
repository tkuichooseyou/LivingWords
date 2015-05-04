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
                    let expected = "16\"For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for last verse of a chapter") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "Genesis"
                    parsedVerse.chapterStart = 1
                    parsedVerse.numberStart = 31
                    parsedVerse.chapterEnd = 1
                    parsedVerse.numberEnd = 31
                    let expected = "31And God saw everything that he had made, and behold, it was very good. And there was evening and there was morning, the sixth day."

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

                    let expected = "5God called the light Day, and the darkness he called Night. And there was evening and there was morning, the first day."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for verse with space in book name") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "1 Corinthians"
                    parsedVerse.chapterStart = 1
                    parsedVerse.numberStart = 2
                    parsedVerse.chapterEnd = 1
                    parsedVerse.numberEnd = 2
                    let expected = "2To the church of God that is in Corinth, to those sanctified in Christ Jesus, called to be saints together with all those who in every place call upon the name of our Lord Jesus Christ, both their Lord and ours:"

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
                    let expected = "21 The LORD visited Sarah as he had said, and the LORD did to Sarah as he had promised."

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
                    let expected = "16\"For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life. 17For God did not send his Son into the world to condemn the world, but in order that the world might be saved through him. 18Whoever believes in him is not condemned, but whoever does not believe is condemned already, because he has not believed in the name of the only Son of God."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns text for verse and includes text of random span inside") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "2 Corinthians"
                    parsedVerse.chapterStart = 12
                    parsedVerse.numberStart = 9
                    parsedVerse.chapterEnd = 12
                    parsedVerse.numberEnd = 9
                    let expected = "9But he said to me, \"My grace is sufficient for you, for my power is made perfect in weakness.\" Therefore I will boast all the more gladly of my weaknesses, so that the power of Christ may rest upon me."

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns verse not found for non-existing verse") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    parsedVerse.chapterStart = 3
                    parsedVerse.numberStart = 100
                    parsedVerse.chapterEnd = 3
                    parsedVerse.numberEnd = 100
                    let expected = "Verse not found"

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }

                it("returns verse not found for verse end before start") {
                    let parsedVerse = ParsedVerse()
                    parsedVerse.book = "John"
                    parsedVerse.chapterStart = 3
                    parsedVerse.numberStart = 105
                    parsedVerse.chapterEnd = 3
                    parsedVerse.numberEnd = 103
                    let expected = "Verse not found"

                    let result = BibleParser.textForParsedVerse(parsedVerse)

                    expect(result) == expected
                }
            }
        }
    }
}
