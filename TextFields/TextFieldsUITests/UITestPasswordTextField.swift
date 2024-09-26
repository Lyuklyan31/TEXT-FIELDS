import XCTest
@testable import TextFields

final class UITestPasswordTextField: XCTestCase {

    // MARK: - Properties
    var app: XCUIApplication!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Tests

    // MARK: - Test Password Text Field for Digits
    @MainActor
    func testPasswordTextFieldDigit() throws {
        let textField = app.textFields["passwordTextField"]
        XCTAssertTrue(textField.exists, "Password text field should exist")
        
        let backgroundView = app.otherElements["passwordBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("1")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "1", "")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "passwordBorder-color-systemBlue", "Expected border color to be blue, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        let digitLabel = app.staticTexts["minimumDigitLabel"]
        XCTAssertEqual(digitLabel.label, "✔︎ minimum 1 digit", "The digit requirement label does not match.")
        XCTAssertEqual(digitLabel.value as? String, "passwordCharacterCountLabel-color-darkGreen", "")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "passwordBorder-color-fieldGrey", "")
    }

    // MARK: - Test Password Text Field for Uppercase Letters
    @MainActor
    func testPasswordTextFieldCapital() throws {
        let textField = app.textFields["passwordTextField"]
        XCTAssertTrue(textField.exists, "Password text field should exist")
        
        let backgroundView = app.otherElements["passwordBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("P")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "P", "")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "passwordBorder-color-systemBlue", "Expected border color to be blue, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        let upperCaseLabel = app.staticTexts["minimumUppercaseLabel"]
        XCTAssertEqual(upperCaseLabel.label, "✔︎ minimum 1 capital letter.", "")
        XCTAssertEqual(upperCaseLabel.value as? String, "passwordCharacterCountLabel-color-darkGreen", "")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "passwordBorder-color-fieldGrey", "")
    }

    // MARK: - Test Password Text Field for Lowercase Letters
    @MainActor
    func testPasswordTextFieldLowerCase() throws {
        let textField = app.textFields["passwordTextField"]
        XCTAssertTrue(textField.exists, "Password text field should exist")
        
        let backgroundView = app.otherElements["passwordBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("a")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "a", "")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "passwordBorder-color-systemBlue", "Expected border color to be blue, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        let lowercaseLabel = app.staticTexts["minimumLowercaseLabel"]
        XCTAssertEqual(lowercaseLabel.label, "✔︎ minimum 1 lowercase", "The digit requirement label does not match.")
        XCTAssertEqual(lowercaseLabel.value as? String, "passwordCharacterCountLabel-color-darkGreen", "")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "passwordBorder-color-fieldGrey", "")
    }

    // MARK: - Test Password Text Field for Length Requirement
    @MainActor
    func testPasswordTextField8Symbols() throws {
        let textField = app.textFields["passwordTextField"]
        XCTAssertTrue(textField.exists, "Password text field should exist")
        
        let backgroundView = app.otherElements["passwordBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("1Password")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "1Password", "")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "passwordBorder-color-systemBlue", "Expected border color to be blue, but found \(borderColor ?? "nil").")
        
        // Verify character count labels
        let lengthLabelTest = app.staticTexts["minimumLengthLabel"]
        let digitLabelTest = app.staticTexts["minimumDigitLabel"]
        let lowercaseLabelTest = app.staticTexts["minimumLowercaseLabel"]
        let uppercaseLabelTest = app.staticTexts["minimumUppercaseLabel"]

        XCTAssertEqual(lengthLabelTest.label, "✔︎ minimum of 8 characters.", "The length requirement label does not match.")
        XCTAssertEqual(digitLabelTest.label, "✔︎ minimum 1 digit", "The digit requirement label does not match.")
        XCTAssertEqual(lowercaseLabelTest.label, "✔︎ minimum 1 lowercase", "The lowercase requirement label does not match.")
        XCTAssertEqual(uppercaseLabelTest.label, "✔︎ minimum 1 capital letter.", "The uppercase requirement label does not match.")

        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "passwordBorder-color-fieldGrey", "")
    }
}
