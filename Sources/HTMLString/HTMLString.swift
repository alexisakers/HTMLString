import Foundation

// MARK: Escaping

extension String {

    ///
    /// Returns a copy of the current `String` where every character incompatible with HTML Unicode
    /// encoding (UTF-16 or UTF-8) is replaced by a decimal HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity (part of the Unicode special characters) |
    /// | `Σ` | `Σ` | Not escaped (Unicode compliant) |
    /// | `🇺🇸` | `🇺🇸` | Not escaped (Unicode compliant) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///

    public var addingUnicodeEntities: String {
        var copy = self
        copy.addUnicodeEntities()
        return copy
    }

    ///
    /// Replaces every character incompatible with HTML Unicode encoding (UTF-16 or UTF-8) by a decimal HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity (part of the Unicode special characters) |
    /// | `Σ` | `Σ` | Not escaped (Unicode compliant) |
    /// | `🇺🇸` | `🇺🇸` | Not escaped (Unicode compliant) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///

    public mutating func addUnicodeEntities() {
        var position: String.Index? = startIndex
        let requiredEscapes: Set<Character> = ["!", "\"", "$", "%", "&", "'", "+", ",", "<", "=", ">", "@", "[", "]", "`", "{", "}"]

        while let cursorPosition = position {
            guard cursorPosition != endIndex else { break }
            let character = self[cursorPosition]

            if requiredEscapes.contains(character) {
                // One of the required escapes for security reasons
                let escape = "&#\(character.asciiValue!);" // required escapes can can only be ASCII
                position = positionAfterReplacingCharacter(at: cursorPosition, with: escape)
            } else {
                // Not a required escape, no need to replace the character
                position = index(cursorPosition, offsetBy: 1, limitedBy: endIndex)
            }
        }
    }

    ///
    /// Returns a copy of the current `String` where every character incompatible with HTML ASCII
    /// encoding is replaced by a decimal HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity |
    /// | `Σ` | `&#931;` | Decimal entity |
    /// | `🇺🇸` | `&#127482;&#127480;` | Combined decimal entities (extented grapheme cluster) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///
    /// ### Performance
    ///
    /// If your webpage is unicode encoded (UTF-16 or UTF-8) use `addingUnicodeEntities` instead,
    /// as it is faster and produces a less bloated and more readable HTML.
    ///

    public var addingASCIIEntities: String {
        var copy = self
        copy.addASCIIEntities()
        return copy
    }

    ///
    /// Replaces every character incompatible with HTML Unicode (UTF-16 or UTF-8) with a decimal HTML entity.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&` | `&#38;` | Decimal entity (part of the Unicode special characters) |
    /// | `Σ` | `Σ` | Not escaped (Unicode compliant) |
    /// | `🇺🇸` | `🇺🇸` | Not escaped (Unicode compliant) |
    /// | `a` | `a` | Not escaped (alphanumerical) |
    ///

    public mutating func addASCIIEntities() {
        var position: String.Index? = startIndex
        let requiredEscapes: Set<Character> = ["!", "\"", "$", "%", "&", "'", "+", ",", "<", "=", ">", "@", "[", "]", "`", "{", "}"]

        while let cursorPosition = position {
            guard cursorPosition != endIndex else { break }
            let character = self[cursorPosition]

            if let asciiiValue = character.asciiValue {
                if requiredEscapes.contains(character) {
                    // One of the required escapes for security reasons
                    let escape = "&#\(asciiiValue);"
                    position = positionAfterReplacingCharacter(at: cursorPosition, with: escape)
                } else {
                    // Not a required escape, no need to replace the character
                    position = index(cursorPosition, offsetBy: 1, limitedBy: endIndex)
                }
            } else {
                // Not an ASCII Character, we need to escape.
                let escape = character.unicodeScalars.reduce(into: "") { $0 += "&#\($1.value);" }
                position = positionAfterReplacingCharacter(at: cursorPosition, with: escape)
            }
        }
    }

}

// MARK: - Unescaping

extension String {

    ///
    /// Replaces every HTML entity in the receiver with the matching Unicode character.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&amp;` | `&` | Keyword entity |
    /// | `&#931;` | `Σ` | Decimal entity |
    /// | `&#x10d;` | `č` | Hexadecimal entity |
    /// | `&#127482;&#127480;` | `🇺🇸` | Combined decimal entities (extented grapheme cluster) |
    /// | `a` | `a` | Not an entity |
    /// | `&` | `&` | Not an entity |
    ///

    public mutating func removeHTMLEntities() {
        var cursorPosition = startIndex

        while let delimiterRange = range(of: "&", range: cursorPosition ..< endIndex) {
            // Avoid unnecessary operations
            guard let semicolonRange = range(of: ";", range: delimiterRange.upperBound ..< endIndex) else {
                cursorPosition = delimiterRange.upperBound
                break
            }

            let escapableRange = delimiterRange.upperBound ..< semicolonRange.lowerBound
            let replaceableRange = delimiterRange.lowerBound ..< semicolonRange.upperBound
            let escapableContent = self[escapableRange]

            if let unescapedNumber = escapableContent.unescapeAsNumber() {
                self.replaceSubrange(replaceableRange, with: unescapedNumber)
                cursorPosition = self.index(delimiterRange.lowerBound, offsetBy: unescapedNumber.count)
            } else if let unescapedCharacter = HTMLStringMappings.shared.unescapingTable[String(escapableContent)] {
                self.replaceSubrange(replaceableRange, with: unescapedCharacter)
                cursorPosition = self.index(delimiterRange.lowerBound, offsetBy: unescapedCharacter.count)
            } else {
                cursorPosition = semicolonRange.upperBound
            }
        }
    }

    ///
    /// Returns a copy of the current `String` where every HTML entity is replaced with the matching
    /// Unicode character.
    ///
    /// ### Examples
    ///
    /// | String | Result | Format |
    /// |--------|--------|--------|
    /// | `&amp;` | `&` | Keyword entity |
    /// | `&#931;` | `Σ` | Decimal entity |
    /// | `&#x10d;` | `č` | Hexadecimal entity |
    /// | `&#127482;&#127480;` | `🇺🇸` | Combined decimal entities (extented grapheme cluster) |
    /// | `a` | `a` | Not an entity |
    /// | `&` | `&` | Not an entity |
    ///

    public var removingHTMLEntities: String {
        var copy = self
        copy.removeHTMLEntities()
        return copy
    }

}

// MARK: - Helpers

extension StringProtocol {

    /// Unescapes the receives as a number if possible.
    fileprivate func unescapeAsNumber() -> String? {
        guard hasPrefix("#") else { return nil }

        let unescapableContent = self.dropFirst()
        let isHexadecimal = unescapableContent.hasPrefix("x") || hasPrefix("X")
        let radix = isHexadecimal ? 16 : 10

        guard let numberStartIndex = unescapableContent.index(unescapableContent.startIndex, offsetBy: isHexadecimal ? 1 : 0, limitedBy: unescapableContent.endIndex) else {
            return nil
        }

        let numberString = unescapableContent[numberStartIndex ..< endIndex]

        guard let codePoint = UInt32(numberString, radix: radix), let scalar = UnicodeScalar(codePoint) else {
            return nil
        }

        return String(scalar)
    }

}

extension String {

    /// Replaces the character at the given position with the escape and returns the new position.
    fileprivate mutating func positionAfterReplacingCharacter(at position: String.Index, with escape: String) -> String.Index? {
        let nextIndex = index(position, offsetBy: 1)

        if let fittingPosition = index(position, offsetBy: escape.count, limitedBy: endIndex) {
            // Check if we can fit the whole escape in the receiver
            replaceSubrange(position ..< nextIndex, with: escape)
            return fittingPosition
        } else {
            // If we can't, remove the character and insert the escape to make it fit.
            remove(at: position)
            insert(contentsOf: escape, at: position)
            return index(position, offsetBy: escape.count, limitedBy: endIndex)
        }
    }

}
