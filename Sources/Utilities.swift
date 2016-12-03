/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   Utilities.swift
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

import Foundation

// MARK: - Dictionary+AllKeys

extension Dictionary where Value: Equatable {

    ///
    /// Returns all the keys with the specified value.
    ///

    func allKeys(withValue value: Value) -> [Key] {
        return filter { $1 == value }.map { $0.0 }
    }

}

// MARK: - Escaping

internal extension Character {

    ///
    /// Escapes the character for ASCII web pages.
    ///

    internal var escapingForASCII: String {

        let str = String(self)

        if let escapeSequence = HTMLEscaping.escapeSequenceTable.allKeys(withValue: str).first {
            return "&" + escapeSequence + ";"
        } else {
            return str.unicodeScalars.map { $0.escapingForASCII }.joined()
        }

    }

    ///
    /// Escapes the character for Unicode web pages.
    ///

    internal var escapingForUnicode: String {
        return String(self).unicodeScalars.map { $0.escapingIfNeeded }.joined()
    }

}

internal extension UnicodeScalar {

    ///
    /// Escapes the scalar for ASCII web pages.
    ///

    internal var escapingForASCII: String {
        return isASCII ? escapingIfNeeded : ("&#" + String(value) + ";")
    }

    ///
    /// Escapes the scalar if needed.
    ///
    /// A scalar needs to be escaped if its value exists in the `HTMLEscaping.escapedCharactersTable`.
    ///

    internal var escapingIfNeeded: String {

        guard let escapedCharacter = HTMLEscaping.escapedCharactersTable[value] else {
            return String(Character(self))
        }

        return ("&" + escapedCharacter + ";")

    }

}
