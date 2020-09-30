import XCTest
@testable import HTMLString

extension HTMLStringTests {
    func testLargeUnescapingPerformanceStringFromObjc() {
        // baseline average: 0.3s
        self.measure {
            _ = TestDataObjc.htmlTestLongUnescapableString().removingHTMLEntities
        }
    }
}
