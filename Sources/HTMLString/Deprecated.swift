import Foundation

fileprivate func unavailable(_ fn: String = #function, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("[HTMLString] \(fn) is not available.", file: file, line: line)
}

extension String {

    @available(*, unavailable, deprecated: 2.2, renamed: "addingUnicodeEntities")
    public var escapingForUnicodeHTML: String {
        unavailable()
    }

    @available(*, unavailable, deprecated: 2.2, renamed: "addingASCIIEntities")
    public var escapingForASCIIHTML: String {
        unavailable()
    }

    @available(*, unavailable, deprecated: 2.2, renamed: "removingHTMLEntities")
    public var unescapingFromHTML: String {
        unavailable()
    }

}

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension NSString {

    @available(*, unavailable, deprecated: 2.2, renamed: "stringByAddingUnicodeEntities")
    @objc public func stringByEscapingForUnicodeHTML() -> NSString {
        unavailable()
    }

    @available(*, unavailable, deprecated: 2.2, renamed: "stringByAddingASCIIEntities")
    @objc public func stringByEscapingForASCIIHTML() -> NSString {
        unavailable()
    }

    @available(*, unavailable, deprecated: 2.2, renamed: "stringByRemovingHTMLEntities")
    @objc public func stringByUnescapingFromHTML() -> NSString {
        unavailable()
    }
        
}
    
#endif
