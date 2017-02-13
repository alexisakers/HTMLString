import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension NSString {

    ///
    /// Returns a new string made from the `NSString` by replacing every character
    /// incompatible with HTML Unicode encoding (UTF-16 or UTF-8) by a standard
    /// HTML escape.
    ///
    /// - returns: The escaped `NSString`.
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

    @objc public func stringByEscapingForASCIIHTML() -> NSString {
        let escaped = (self as String).escapingForASCIIHTML
        return escaped as NSString
    }

    ///
    /// Returns a new string made from the `String` by replacing every character
    /// incompatible with HTML ASCII encoding by a standard HTML escape.
    ///
    /// - returns: The escaped `NSString`.
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

    @objc public func stringByEscapingForUnicodeHTML() -> NSString {
        let escaped = (self as String).escapingForUnicodeHTML
        return escaped as NSString
    }

    ///
    /// Returns a new string made from the `String` by replacing every HTML escape
    /// sequence with the matching Unicode character.
    ///
    /// - returns: The unescaped `NSString`.
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

    @objc public func stringByUnescapingFromHTML() -> NSString {
        let escaped = (self as String).unescapingFromHTML
        return escaped as NSString
    }

}

#endif
