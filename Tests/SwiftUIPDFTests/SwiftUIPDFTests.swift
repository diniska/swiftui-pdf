import XCTest
@testable import SwiftUIPDF

final class SwiftUIPDFTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftUIPDF().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
