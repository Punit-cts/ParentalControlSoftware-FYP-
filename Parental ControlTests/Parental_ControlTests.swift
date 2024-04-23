import XCTest
@testable import Parental_Control

class Parental_ControlAppTests: XCTestCase {

    func testParental_ControlApp() {
        let app = Parental_ControlApp()
        
        XCTAssertNotNil(app)
    }

    func testAppDelegate() {
        let appDelegate = AppDelegate()
        
        XCTAssertNotNil(appDelegate)
    }

    // Additional test cases can be added to validate specific functionalities.
}
