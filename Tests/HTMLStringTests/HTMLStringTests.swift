import XCTest
@testable import HTMLString

///
/// Tests HTML escaping/unescaping.
///

class HTMLStringTests: XCTestCase {

    // MARK: - Escaping

    ///
    /// Tests escaping a string for ASCII.
    ///

    func testStringASCIIEscaping() {

        let namedEscape = ("Fish & Chips").addingASCIIEntities
        XCTAssertEqual(namedEscape, "Fish &#38; Chips")

        let namedDualEscape = ("a ⪰̸ b").addingASCIIEntities
        XCTAssertEqual(namedDualEscape, "a &#10928;&#824; b")

        let emojiEscape = ("Hey 🙃").addingASCIIEntities
        XCTAssertEqual(emojiEscape, "Hey &#128579;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").addingASCIIEntities
        XCTAssertEqual(doubleEmojiEscape, "Going to the &#127482;&#127480; next June")

    }

    ///
    /// Tests escaping a string for Unicode.
    ///

    func testStringUnicodeEscaping() {

        let requiredEscape = ("Fish & Chips").addingUnicodeEntities
        XCTAssertEqual(requiredEscape, "Fish &#38; Chips")

        let namedDualEscape = ("a ⪰̸ b").addingUnicodeEntities
        XCTAssertEqual(namedDualEscape, "a ⪰̸ b")

        let emojiEscape = ("Hey 🙃!").addingUnicodeEntities
        XCTAssertEqual(emojiEscape, "Hey 🙃&#33;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").addingUnicodeEntities
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

    }

    // MARK: - Unescaping

    ///
    /// Tests unescaping sequences.
    ///

    func testUnescaping() {

        let withoutMarker = "Hello, world.".removingHTMLEntities
        XCTAssertEqual(withoutMarker, "Hello, world.")

        let noSemicolon = "Fish & Chips".removingHTMLEntities
        XCTAssertEqual(noSemicolon, "Fish & Chips")

        let decimal = "My phone number starts with a &#49;".removingHTMLEntities
        XCTAssertEqual(decimal, "My phone number starts with a 1")

        let invalidDecimal = "My phone number starts with a &#4_9;!".removingHTMLEntities
        XCTAssertEqual(invalidDecimal, "My phone number starts with a &#4_9;!")

        let hex = "Let's meet at the caf&#xe9;".removingHTMLEntities
        XCTAssertEqual(hex, "Let's meet at the café")

        let invalidHex = "Let's meet at the caf&#xzi;!".removingHTMLEntities
        XCTAssertEqual(invalidHex, "Let's meet at the caf&#xzi;!")

        let invalidUnicodePoint = "What is this character ? -> &#xd8ff;".removingHTMLEntities
        XCTAssertEqual(invalidUnicodePoint, "What is this character ? -> &#xd8ff;")

        let badSequence = "I love &swift;".removingHTMLEntities
        XCTAssertEqual(badSequence, "I love &swift;")

        let goodSequence = "Do you know &aleph;?".removingHTMLEntities
        XCTAssertEqual(goodSequence, "Do you know ℵ?")

        let twoSequences = "a &amp;&amp; b".removingHTMLEntities
        XCTAssertEqual(twoSequences, "a && b")

        let doubleEmojiEscape = ("Going to the &#127482;&#127480; next June").removingHTMLEntities
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

    }

    // MARK: - Benchmark

    ///
    /// Measures the performance of unescaping.
    ///

    func testUnescapingPerformance() {

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

    ///
    /// Measures performance of unescaping.
    ///

    func testEscapingPerformance() {

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

}

extension HTMLStringTests {

    static var allTests: [(String, (HTMLStringTests) -> () throws -> Void)] {
        return [
            ("testStringASCIIEscaping", testStringASCIIEscaping),
            ("testStringUnicodeEscaping", testStringUnicodeEscaping),
            ("testUnescaping", testUnescaping),
            ("testUnescapingPerformance", testUnescapingPerformance),
            ("testEscapingPerformance", testEscapingPerformance)
        ]
    }

}
