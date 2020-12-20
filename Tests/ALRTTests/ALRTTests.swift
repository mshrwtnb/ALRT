import XCTest
@testable import ALRT

final class ALRTTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ALRT().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
