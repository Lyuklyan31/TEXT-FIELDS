import XCTest
@testable import TextFields

final class UITestOnlyCharactersTextField: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Test Cases
    
    // MARK: Test N1 - Only Letters
    @MainActor
    func testOnlyCharactersTextFieldOnlyLetters() throws {
        let textField = app.textFields["onlyCharactersTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")

        let backgroundView = app.otherElements["onlyCharactersBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "onlyCharactersBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("abcdefghrd")
        
        // Check the value of the text field
        XCTAssertEqual(textField.value as? String, "abcde-", "Expected text field value to be 'abcde-', but found \(textField.value as? String ?? "nil").")
        
        // Check the border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "onlyCharactersBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap() // Tap outside to dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "onlyCharactersBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
    
    // MARK: - Test N2 - More Than One
    func testOnlyCharactersTextFieldMoreThanOne() throws {
        let textField = app.textFields["onlyCharactersTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")

        let backgroundView = app.otherElements["onlyCharactersBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "onlyCharactersBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("abcde123456")
        
        // Check the value of the text field
        XCTAssertEqual(textField.value as? String, "abcde-12345", "Expected text field value to be 'abcde-12345' after inputting more than 10 characters.")
        
        // Check the border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "onlyCharactersBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap() // Tap outside to dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "onlyCharactersBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
    
    // MARK: - Test N3 - Letters and Digits
    func testOnlyCharactersTextFieldLettersAndDigits() throws {
        let textField = app.textFields["onlyCharactersTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")

        let backgroundView = app.otherElements["onlyCharactersBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "onlyCharactersBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("abcde12345")
        
        // Check the value of the text field
        XCTAssertEqual(textField.value as? String, "abcde-12345", "Expected text field value to be 'abcde-12345' after inputting letters and digits.")
        
        // Check the border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "onlyCharactersBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap() // Tap outside to dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "onlyCharactersBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
    
    // MARK: - Test N4 - Mixed Letters and Digits
    func testOnlyCharactersTextFieldMixedLettersAndDigits() throws {
        let textField = app.textFields["onlyCharactersTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")

        let backgroundView = app.otherElements["onlyCharactersBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "onlyCharactersBackgroundView should exist.")
        
        textField.tap()
        textField.typeText("1ab2cd1f2345")
        
        // Check the value of the text field
        XCTAssertEqual(textField.value as? String, "abcdf-2345", "Expected text field value to be 'abcdf-2345' after inputting mixed letters and digits.")
        
        // Check the border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "onlyCharactersBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        app.tap() // Tap outside to dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "onlyCharactersBorder-color-fieldGray", "Expected border color to be fieldGray after editing ends.")
    }
}
