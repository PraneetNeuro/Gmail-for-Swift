import XCTest
@testable import Smail

final class SmailTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Smail().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
