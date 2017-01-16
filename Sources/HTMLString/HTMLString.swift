/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   HTMLString.swift
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

import Foundation

// MARK: Escaping

public extension String {

    ///
    /// Returns a new string made from the `String` by replacing every character
    /// incompatible with HTML Unicode encoding (UTF-16 or UTF-8) by a standard
    /// HTML escape.
    ///
    /// ### Examples
    ///
    /// | String | Result  | Format                                                  |
    /// |--------|---------|---------------------------------------------------------|
    /// | `&`    | `&#38;` | Decimal escape (part of the Unicode special characters) |
    /// | `Σ`    | `Σ`     | Not escaped (Unicode compliant)                         |
    /// | `🇺🇸`   | `🇺🇸`     | Not escaped (Unicode compliant)                         |
    /// | `a`    | `a`     | Not escaped (alphanumerical)                            |
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    public var escapingForUnicodeHTML: String {
        return unicodeScalars.reduce("") { $0 + $1.escapingIfNeeded }
    }

    ///
    /// Returns a new string made from the `String` by replacing every character
    /// incompatible with HTML ASCII encoding by a standard HTML escape.
    ///
    /// ### Examples
    ///
    /// | String | Result               | Format                                               |
    /// |--------|----------------------|------------------------------------------------------|
    /// | `&`    | `&#38;`              | Keyword escape                                       |
    /// | `Σ`    | `&#931;`             | Decimal escape                                       |
    /// | `🇺🇸`   | `&#127482;&#127480;` | Combined decimal escapes (extented grapheme cluster) |
    /// | `a`    | `a`                  | Not escaped (alphanumerical)                         |
    ///
    /// ### Performance
    ///
    /// If your webpage is unicode encoded (UTF-16 or UTF-8) use `escapingForUnicodeHTML` instead 
    /// as it is faster, and produces less bloated and more readable HTML (as long as you are using 
    /// a unicode compliant HTML reader).
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    public var escapingForASCIIHTML: String {
        return unicodeScalars.reduce("") { $0 + $1.escapingForASCII }
    }

}

// MARK: - Unescaping

extension String {

    ///
    /// Returns a new string made from the `String` by replacing every HTML escape
    /// sequence with the matching Unicode character.
    ///
    /// ### Examples
    ///
    /// | String               | Result                 | Format                             |
    /// |----------------------|------------------------|------------------------------------|
    /// | `&amp;`              | `&`  | Keyword escape                                       |
    /// | `&#931;`             | `Σ`  | Decimal escape                                       |
    /// | `&#x10d;`            | `č`  | Hexadecimal escape                                   |
    /// | `&#127482;&#127480;` | `🇺🇸` | Combined decimal escapes (extented grapheme cluster) |
    /// | `a`                  | `a`  | Not an escape                                        |
    /// | `&`                  | `&`  | Not an escape                                        |
    ///
    /// **Complexity**: `O(N)` where `N` is the number of characters in the string.
    ///

    public var unescapingFromHTML: String {

        guard self.contains("&") else {
            return self
        }

        var result = String()
        var idx = startIndex

        while let delimiterRange = range(of: "&", range: idx ..< endIndex) {

            // Avoid unnecessary operations
            let head = self[idx ..< delimiterRange.lowerBound]
            result += head

            guard let semicolonRange = range(of: ";", range: delimiterRange.upperBound ..< endIndex) else {
                result += "&"
                idx = delimiterRange.upperBound
                break
            }

            let escapableContent = self[delimiterRange.upperBound ..< semicolonRange.lowerBound]
            let replacementString: String

            if escapableContent.hasPrefix("#") {

                guard let unescapedNumber = escapableContent.unescapeAsNumber() else {
                    result += self[delimiterRange.lowerBound ..< semicolonRange.upperBound]
                    idx = semicolonRange.upperBound
                    continue
                }

                replacementString = unescapedNumber

            } else {

                guard let unescapedCharacter = HTMLTables.unescapingTable[escapableContent] else {
                    result += self[delimiterRange.lowerBound ..< semicolonRange.upperBound]
                    idx = semicolonRange.upperBound
                    continue
                }

                replacementString = unescapedCharacter

            }

            result += replacementString
            idx = semicolonRange.upperBound

        }

        // Append unprocessed data, if unprocessed data there is
        let tail = self[idx ..< endIndex]
        result += tail

        return result

    }

    private func unescapeAsNumber() -> String? {

        let isHexadecimal = self.hasPrefix("#X") || self.hasPrefix("#x")

        let numberStartIndexOffset = isHexadecimal ? 2 : 1
        let numberString = self [ index(startIndex, offsetBy: numberStartIndexOffset) ..< endIndex ]

        let radix = isHexadecimal ? 16 : 10

        guard let codePoint = UInt32(numberString, radix: radix),
              let scalar = UnicodeScalar(codePoint) else {
            return nil
        }

        return String(scalar)

    }

}

// MARK: - UnicodeScalar+Escape

extension UnicodeScalar {

    ///
    /// Returns the decimal HTML escape of the Unicode scalar.
    ///
    /// This allows you to perform custom escaping.
    ///

    public var htmlEscaped: String {
        return "&#" + String(value) + ";"
    }

    ///
    /// The scalar escaped for ASCII encoding.
    ///

    fileprivate var escapingForASCII: String {
        return isASCII ? escapingIfNeeded : htmlEscaped
    }

    ///
    /// Escapes the scalar only if it needs to be escaped for Unicode pages.
    ///
    /// [Reference](http://wonko.com/post/html-escaping)
    /// 

    fileprivate var escapingIfNeeded: String {

        switch value {
        case 33, 34, 36, 37, 38, 39, 43, 44, 60, 61, 62, 64, 91, 93, 96, 123, 125: return htmlEscaped
        default: return String(self)
        }

    }

}
