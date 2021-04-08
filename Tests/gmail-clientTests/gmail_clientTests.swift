import XCTest
@testable import gmail_client

final class gmail_clientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(gmail_client().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
