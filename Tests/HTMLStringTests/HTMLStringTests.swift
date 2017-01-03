/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   HTMLStringTests.swift
 *  Project         :   HTMLString
 *  Author          :   Alexis Aubry Radanovic
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016-2017 Alexis Aubry Radanovic
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

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

        let namedEscape = ("Fish & Chips").escapingForASCIIHTML
        XCTAssertEqual(namedEscape, "Fish &amp; Chips")

        let namedDualEscape = ("a ⪰̸ b").escapingForASCIIHTML
        XCTAssertEqual(namedDualEscape, "a &#10928;&#824; b")

        let emojiEscape = ("Hey 🙃").escapingForASCIIHTML
        XCTAssertEqual(emojiEscape, "Hey &#128579;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").escapingForASCIIHTML
        XCTAssertEqual(doubleEmojiEscape, "Going to the &#127482;&#127480; next June")

    }

    ///
    /// Tests escaping a string for Unicode.
    ///

    func testStringUnicodeEscaping() {

        let requiredEscape = ("Fish & Chips").escapingForUnicodeHTML
        XCTAssertEqual(requiredEscape, "Fish &amp; Chips")

        let namedDualEscape = ("a ⪰̸ b").escapingForUnicodeHTML
        XCTAssertEqual(namedDualEscape, "a ⪰̸ b")

        let emojiEscape = ("Hey 🙃!").escapingForUnicodeHTML
        XCTAssertEqual(emojiEscape, "Hey 🙃!")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").escapingForUnicodeHTML
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

    }

    // MARK: - Unescaping

    ///
    /// Tests unescaping sequences.
    ///

    func testUnescaping() {

        let withoutMarker = "Hello, world.".unescapingFromHTML
        XCTAssertEqual(withoutMarker, "Hello, world.")

        let noSemicolon = "Fish & Chips".unescapingFromHTML
        XCTAssertEqual(noSemicolon, "Fish & Chips")

        let decimal = "My phone number starts with a &#49;".unescapingFromHTML
        XCTAssertEqual(decimal, "My phone number starts with a 1")

        let invalidDecimal = "My phone number starts with a &#4_9;!".unescapingFromHTML
        XCTAssertEqual(invalidDecimal, "My phone number starts with a &#4_9;!")

        let hex = "Let's meet at the caf&#xe9;".unescapingFromHTML
        XCTAssertEqual(hex, "Let's meet at the café")

        let invalidHex = "Let's meet at the caf&#xzi;!".unescapingFromHTML
        XCTAssertEqual(invalidHex, "Let's meet at the caf&#xzi;!")

        let invalidUnicodePoint = "What is this character ? -> &#xd8ff;".unescapingFromHTML
        XCTAssertEqual(invalidUnicodePoint, "What is this character ? -> &#xd8ff;")

        let badSequence = "I love &swift;".unescapingFromHTML
        XCTAssertEqual(badSequence, "I love &swift;")

        let goodSequence = "Do you know &aleph;?".unescapingFromHTML
        XCTAssertEqual(goodSequence, "Do you know ℵ?")

        let twoSequences = "a &amp;&amp; b".unescapingFromHTML
        XCTAssertEqual(twoSequences, "a && b")

        let doubleEmojiEscape = ("Going to the &#127482;&#127480; next June").unescapingFromHTML
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

    }

    // MARK: - Benchmark

    ///
    /// Measures the performance of unescaping.
    ///

    func testUnescapingPerformance() {

        self.measure {

            _ = "Hello, world.".unescapingFromHTML
            _ = "Fish & Chips".unescapingFromHTML
            _ = "My phone number starts with a &#49;".unescapingFromHTML
            _ = "My phone number starts with a &#4_9;!".unescapingFromHTML
            _ = "Let's meet at the caf&#xe9;".unescapingFromHTML
            _ = "Let's meet at the caf&#xzi;!".unescapingFromHTML
            _ = "What is this character ? -> &#xd8ff;".unescapingFromHTML
            _ = "I love &swift;".unescapingFromHTML
            _ = "Do you know &aleph;?".unescapingFromHTML
            _ = "a &amp;&amp; b".unescapingFromHTML

        }

    }

    ///
    /// Measures performance of unescaping.
    ///

    func testEscapingPerformance() {

        self.measure {
/*
            _ = Character("&").escapingForASCII
            _ = Character("⪰̸").escapingForASCII
            _ = Character("🙃").escapingForASCII
            _ = Character("🇺🇸").escapingForASCII
            _ = Character("A").escapingForASCII

            _ = Character("&").escapingForUnicode
            _ = Character("⪰̸").escapingForUnicode
            _ = Character("🙃").escapingForUnicode
            _ = Character("🇺🇸").escapingForUnicode
            _ = Character("A").escapingForUnicode
*/
            _ = ("Fish & Chips").escapingForASCIIHTML
            _ = ("a ⪰̸ b").escapingForASCIIHTML
            _ = ("Hey 🙃").escapingForASCIIHTML
            _ = ("Going to the 🇺🇸 next June").escapingForASCIIHTML

            _ = ("Fish & Chips").escapingForUnicodeHTML
            _ = ("a ⪰̸ b").escapingForUnicodeHTML
            _ = ("Hey 🙃!").escapingForUnicodeHTML
            _ = ("Going to the 🇺🇸 next June").escapingForUnicodeHTML

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
