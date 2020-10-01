import Foundation

private final class Token {}

extension Bundle {
    static let testResources: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: Token.self)
        #endif
    }()
}
