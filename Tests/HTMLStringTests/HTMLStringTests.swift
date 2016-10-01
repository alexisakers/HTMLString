/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   HTMLStringTests.swift
 *  Project         :   HTMLString
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
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

class HTMLStringTests: XCTestCase {

    func testUnicode() {
     
        let unicodeString = "My favorite emoji is 🙃"
        let escapedUnicode = unicodeString.escapingForUnicodeHTML
        XCTAssertEqual(escapedUnicode, "My favorite emoji is 🙃")
        
        let unicodeWithEscapableScalar = "Fish & Chips"
        let escapedUnicode2 = unicodeWithEscapableScalar.escapingForUnicodeHTML
        XCTAssertEqual(escapedUnicode2, "Fish &amp; Chips")
     
        let dualString = "My favorite emoji is 🙃 & \\_(🙃)_/"
        let escapedUnicode3 = dualString.escapingForUnicodeHTML
        XCTAssertEqual(escapedUnicode3, "My favorite emoji is 🙃 &amp; \\_(🙃)_/")
        
    }
    
    func testASCII() {
        
        let unicodeString = "My favorite emoji is 🙃"
        let escapedUnicode = unicodeString.escapingForASCIIHTML
        XCTAssertEqual(escapedUnicode, "My favorite emoji is &#128579;")
        
        let unicodeWithEscapableScalar = "Fish & Chips"
        let escapedUnicode2 = unicodeWithEscapableScalar.escapingForASCIIHTML
        XCTAssertEqual(escapedUnicode2, "Fish &amp; Chips")
        
        let dualString = "My favorite emoji is 🙃 & \\_(🙃)_/"
        let escapedUnicode3 = dualString.escapingForASCIIHTML
        XCTAssertEqual(escapedUnicode3, "My favorite emoji is &#128579; &amp; \\_(&#128579;)_/")
    
    }
    
    func testUnescaping() {
        
        let decimalEscaped = "My favorite emoji is &#128579;"
        let decimalUnescaped = decimalEscaped.unescapingFromHTML
        XCTAssertEqual(decimalUnescaped, "My favorite emoji is 🙃")
        
        let hexEscaped = "My favorite emoji is &#x1F643;"
        let hexUnescaped = hexEscaped.unescapingFromHTML
        XCTAssertEqual(hexUnescaped, "My favorite emoji is 🙃")
        
        let rawEscaped = "Fish &amp; Chips"
        let rawUnescaped = rawEscaped.unescapingFromHTML
        XCTAssertEqual(rawUnescaped, "Fish & Chips")
        
        let dualString = "My favorite emoji is &#128579; &amp; \\_(&#128579;)_/"
        let escapedUnicode3 = dualString.unescapingFromHTML
        XCTAssertEqual(escapedUnicode3, "My favorite emoji is 🙃 & \\_(🙃)_/")
        
    }

}

extension HTMLStringTests {
    
    static var allTests : [(String, (HTMLStringTests) -> () throws -> Void)] {
        return [
            ("testUnicode", testUnicode),
            ("testASCII", testASCII),
            ("testUnescaping", testUnescaping)
        ]
    }
    
}
