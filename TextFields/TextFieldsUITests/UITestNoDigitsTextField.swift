import XCTest
@testable import TextFields

final class UITestNoDigitsTextField: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    // MARK: - Test Cases

    // MARK: Test N1 - Without Digits
    @MainActor
    func testNoDigitsTextFieldWithoutDigits() throws {
        let textField = app.textFields["noDigitsTextField"]
        XCTAssertTrue(textField.exists, "noDigitsTextField should exist.")
        
        let backgroundView = app.otherElements["noDigitsBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "noDigitsBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("apple")
        
        XCTAssertEqual(textField.value as? String, "apple", "Text field value should match input.")
        
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "noDigitsBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap()
        
        let updatedBorderColor = backgroundView.value as? String
        XCTAssertEqual(updatedBorderColor, "noDigitsBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
    
    // MARK: - Test N2 - With Digits
    @MainActor
    func testNoDigitsTextFieldWithDigits() throws {
        let textField = app.textFields["noDigitsTextField"]
        XCTAssertTrue(textField.exists, "noDigitsTextField should exist.")
        
        let backgroundView = app.otherElements["noDigitsBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "noDigitsBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("1a2p3p4l5e6")
        
        XCTAssertEqual(textField.value as? String, "apple", "Text field value should match input.")
        
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "noDigitsBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap()
        
        let updatedBorderColor = backgroundView.value as? String
        XCTAssertEqual(updatedBorderColor, "noDigitsBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
    
    // MARK: - Test N3 - With Special Signs
    @MainActor
    func testNoDigitsTextFieldWithSpecialSigns() throws {
        let textField = app.textFields["noDigitsTextField"]
        XCTAssertTrue(textField.exists, "noDigitsTextField should exist.")
        
        let backgroundView = app.otherElements["noDigitsBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "noDigitsBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("$a$p$p$l$e")
        
        XCTAssertEqual(textField.value as? String, "$a$p$p$l$e", "Text field value should match input.")
        
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "noDigitsBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap()
        
        let updatedBorderColor = backgroundView.value as? String
        XCTAssertEqual(updatedBorderColor, "noDigitsBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
}
