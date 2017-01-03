/**
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   Utilities.swift
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

// MARK: Cross-Platform Scanner

extension Scanner {

    #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)

        ///
        /// Scans for an unsigned value from a hexadecimal representation.
        ///
        /// Provided on Darwin to match open-source syntax.
        ///
        /// - seealso: scanHexInt32(_:)
        ///

        internal func scanHexInt() -> UInt32? {

            var scannedValue = UInt32()

            guard self.scanHexInt32(&scannedValue) else {
                return nil
            }

            return scannedValue

        }

    #endif

}

// MARK: - Escaping

public extension UnicodeScalar {

    ///
    /// Escapes the scalar for ASCII web pages.
    ///

    public var escapingForASCII: String {
        return isASCII ? escapingIfNeeded : ("&#" + String(value) + ";")
    }

    ///
    /// Escapes the scalar if needed.
    ///
    /// A scalar needs to be escaped if its value exists in the `HTMLTables.requiredEscapingsTable`
    /// dictionary.
    ///

    public var escapingIfNeeded: String {

        // Avoid unnecessary lookups
        guard value > 0x22 && value < 0x20ac else {
            return String(self)
        }

        return HTMLTables.requiredEscapingsTable[value] ?? String(self)

    }

}

