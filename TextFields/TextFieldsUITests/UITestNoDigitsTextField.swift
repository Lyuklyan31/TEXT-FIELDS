import XCTest
@testable import TextFields

final class UITestNoDigitsTextField: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testNoDigitsTextFieldWithoutDigits() throws {
        let app = XCUIApplication()
        app.launch()

        let textField = app.textFields["noDigitsTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        textField.tap()
        textField.typeText("Test input")
        
        XCTAssertEqual(textField.value as? String, "Test input", "Text field value should match input.")
    }
    
    @MainActor
    func testNoDigitsTextFieldWithDigits() throws {
        let app = XCUIApplication()
        app.launch()

        let textField = app.textFields["noDigitsTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        textField.tap()
        textField.typeText("1a2p3p4l5e6")
        
        XCTAssertEqual(textField.value as? String, "apple", "Text field value should match input.")
    }
}
