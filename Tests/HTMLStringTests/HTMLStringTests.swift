import XCTest
@testable import HTMLString

///
/// Tests HTML escaping/unescaping.
///

class HTMLStringTests: XCTestCase {

    // MARK: - Escaping

    /// Tests escaping a string for ASCII.
    func testStringASCIIEscaping() {
        let emptyString = ("").addingASCIIEntities()
        XCTAssertEqual(emptyString, "")

        let namedEscape = ("Fish & Chips").addingASCIIEntities()
        XCTAssertEqual(namedEscape, "Fish &#38; Chips")

        let namedDualEscape = ("a ⪰̸ b").addingASCIIEntities()
        XCTAssertEqual(namedDualEscape, "a &#10928;&#824; b")

        let emojiEscape = ("Hey 🙃").addingASCIIEntities()
        XCTAssertEqual(emojiEscape, "Hey &#128579;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").addingASCIIEntities()
        XCTAssertEqual(doubleEmojiEscape, "Going to the &#127482;&#127480; next June")
    }

    /// Tests escaping a string for Unicode.
    func testStringUnicodeEscaping() {
        let requiredEscape = ("Fish & Chips").addingUnicodeEntities()
        XCTAssertEqual(requiredEscape, "Fish &#38; Chips")

        let namedDualEscape = ("a ⪰̸ b").addingUnicodeEntities()
        XCTAssertEqual(namedDualEscape, "a ⪰̸ b")

        let emojiEscape = ("Hey 🙃!").addingUnicodeEntities()
        XCTAssertEqual(emojiEscape, "Hey 🙃&#33;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").addingUnicodeEntities()
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")
    }

    // MARK: - Unescaping

    /// Tests unescaping strings.
    func testUnescaping() {
        let withoutMarker = "Hello, world.".removingHTMLEntities()
        XCTAssertEqual(withoutMarker, "Hello, world.")

        let noSemicolon = "Fish & Chips".removingHTMLEntities()
        XCTAssertEqual(noSemicolon, "Fish & Chips")

        let decimal = "My phone number starts with a &#49;".removingHTMLEntities()
        XCTAssertEqual(decimal, "My phone number starts with a 1")

        let invalidDecimal = "My phone number starts with a &#4_9;!".removingHTMLEntities()
        XCTAssertEqual(invalidDecimal, "My phone number starts with a &#4_9;!")

        let hex = "Let's meet at the caf&#xe9;".removingHTMLEntities()
        XCTAssertEqual(hex, "Let's meet at the café")

        let invalidHex = "Let's meet at the caf&#xzi;!".removingHTMLEntities()
        XCTAssertEqual(invalidHex, "Let's meet at the caf&#xzi;!")

        let invalidUnicodePoint = "What is this character ? -> &#xd8ff;".removingHTMLEntities()
        XCTAssertEqual(invalidUnicodePoint, "What is this character ? -> &#xd8ff;")

        let badSequence = "I love &swift;".removingHTMLEntities()
        XCTAssertEqual(badSequence, "I love &swift;")

        let goodSequence = "Do you know &aleph;?".removingHTMLEntities()
        XCTAssertEqual(goodSequence, "Do you know ℵ?")

        let twoSequences = "a &amp;&amp; b".removingHTMLEntities()
        XCTAssertEqual(twoSequences, "a && b")

        let doubleEmojiEscape = ("Going to the &#127482;&#127480; next June").removingHTMLEntities()
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

        let textInTheMiddle = "Fish & Chips tastes &quot;great\"".removingHTMLEntities()
        XCTAssertEqual(textInTheMiddle, "Fish & Chips tastes \"great\"")
    }
    
    /// Refer to issue https://github.com/alexaubry/HTMLString/issues/22
    func testNSString() {
        let nsSepcialCharacter = NSString("𝟸𝟺𝟶&deg;")
        let sepcialCharacter = nsSepcialCharacter as String
        XCTAssertEqual(sepcialCharacter.removingHTMLEntities(), "𝟸𝟺𝟶°")
    }

    // MARK: - Open Data

    func testThatItUnescapesSampleData() {
        let review = "44 Fotos und 68 Tipps von 567 Besucher bei NETA Mexican Street Food anzeigen. &quot;Not sharing the enthusiasm of the other reviewers. The tacos were...&quot;"
        let expectedReview = "44 Fotos und 68 Tipps von 567 Besucher bei NETA Mexican Street Food anzeigen. \"Not sharing the enthusiasm of the other reviewers. The tacos were...\""
        XCTAssertEqual(review.removingHTMLEntities(), expectedReview)

        let foursquare = "NETA Mexican Street Food, Weinbergsweg 5, Berlin, Berlin, neta mexican street food, Burritos, Mexikanisch, Nachspeise, Abendessen &amp; more"
        let expectedFoursquare = "NETA Mexican Street Food, Weinbergsweg 5, Berlin, Berlin, neta mexican street food, Burritos, Mexikanisch, Nachspeise, Abendessen & more"
        XCTAssertEqual(foursquare.removingHTMLEntities(), expectedFoursquare)

        let headline = "What&#x27;s it like to drive with Tesla&#x27;s Autopilot and how does it work?"
        let expectedHeadline = "What's it like to drive with Tesla's Autopilot and how does it work?"
        XCTAssertEqual(headline.removingHTMLEntities(), expectedHeadline)
    }

    // MARK: - Benchmark

    /// Measures the average unescaping performance.
    func testUnescapingPerformance() {
        // baseline average: 0.001s
        self.measure {
            _ = "Hello, world.".removingHTMLEntities
            _ = "Fish & Chips".removingHTMLEntities
            _ = "My phone number starts with a &#49;".removingHTMLEntities
            _ = "My phone number starts with a &#4_9;!".removingHTMLEntities
            _ = "Let's meet at the caf&#xe9;".removingHTMLEntities
            _ = "Let's meet at the caf&#xzi;!".removingHTMLEntities
            _ = "What is this character ? -> &#xd8ff;".removingHTMLEntities
            _ = "I love &swift;".removingHTMLEntities
            _ = "Do you know &aleph;?".removingHTMLEntities
            _ = "a &amp;&amp; b".removingHTMLEntities
        }
    }

    /// Measures escaping avergae performance.
    func testEscapingPerformance() {
        // baseline average: 0.001s
        self.measure {
            _ = ("Fish & Chips").addingASCIIEntities
            _ = ("a ⪰̸ b").addingASCIIEntities
            _ = ("Hey 🙃").addingASCIIEntities
            _ = ("Going to the 🇺🇸 next June").addingASCIIEntities

            _ = ("Fish & Chips").addingUnicodeEntities
            _ = ("a ⪰̸ b").addingUnicodeEntities
            _ = ("Hey 🙃!").addingUnicodeEntities
            _ = ("Going to the 🇺🇸 next June").addingUnicodeEntities
        }
    }

    /// Measures the average perforance of unescaping a long String with a large number of entities.
    func testLargeUnescapingPerformance() {
        // baseline average: 0.3s
        self.measure {
            _ = HTMLTestLongUnescapableString.removingHTMLEntities
        }
    }

}

extension HTMLStringTests {

    static var allTests: [(String, (HTMLStringTests) -> () throws -> Void)] {
        return [
            ("testStringASCIIEscaping", testStringASCIIEscaping),
            ("testStringUnicodeEscaping", testStringUnicodeEscaping),
            ("testUnescaping", testUnescaping),
            ("testUnescapingPerformance", testUnescapingPerformance),
            ("testEscapingPerformance", testEscapingPerformance),
            ("testLargeUnescapingPerformance", testLargeUnescapingPerformance)
        ]
    }

}
