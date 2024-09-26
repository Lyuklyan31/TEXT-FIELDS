import XCTest
@testable import TextFields

final class UITestLimitTextField: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - TEST N1: Test Limit TextField with 12 Characters
    @MainActor
    func testLimitTextFieldWith12Characters() throws {
        let textField = app.textFields["limitTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        let characterCountLabel = app.staticTexts["limitCharacterCountLabel"]
        XCTAssertTrue(characterCountLabel.exists, "Character count label should exist.")
        
        let backgroundView = app.otherElements["limitBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("123456789012")
        
        let colorLabel = textField.label
        XCTAssertEqual(colorLabel, "limitTextFieldText-color-red", "Expected text color to be red for characters beyond the limit.")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "123456789012", "Text field value should be '123456789012' after inputting 12 characters.")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "limitBorder-color-red", "Expected border color to be red, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        XCTAssertEqual(characterCountLabel.label, "-2", "Expected character count label to be '-2' after exceeding limit.")
        XCTAssertEqual(characterCountLabel.value as? String, "limitCharacterCountLabel-color-red", "Expected character count color to be red after exceeding limit.")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "limitBorder-color-red", "Expected border color to remain red after editing ends.")
    }
    
    // MARK: - TEST N2: Test Limit TextField with 5 Characters
    @MainActor
    func testLimitTextFieldWith5Characters() throws {
        let textField = app.textFields["limitTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        let characterCountLabel = app.staticTexts["limitCharacterCountLabel"]
        XCTAssertTrue(characterCountLabel.exists, "Character count label should exist.")
        
        let backgroundView = app.otherElements["limitBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("12345")
        
        let colorLabel = textField.label
        XCTAssertEqual(colorLabel, "limitTextFieldText-color-nightRider", "Expected text color to be nightRider for valid characters.")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "12345", "Text field value should be '12345' after inputting 5 characters.")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "limitBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        XCTAssertEqual(characterCountLabel.label, "5", "Expected character count label to be '5' after inputting 5 characters.")
        XCTAssertEqual(characterCountLabel.value as? String, "limitCharacterCountLabel-color-nightRider", "Expected character count color to be nightRider, but found \(characterCountLabel.value ?? "nil").")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "limitBorder-color-fieldGray", "Expected border color to remain fieldGray after editing ends.")
    }

    // MARK: - TEST N3: Test Limit TextField with 10 Characters
    @MainActor
    func testLimitTextFieldWith10Characters() throws {
        let textField = app.textFields["limitTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        let characterCountLabel = app.staticTexts["limitCharacterCountLabel"]
        XCTAssertTrue(characterCountLabel.exists, "Character count label should exist.")
        
        let backgroundView = app.otherElements["limitBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("apple12345")
        
        let colorLabel = textField.label
        XCTAssertEqual(colorLabel, "limitTextFieldText-color-nightRider", "Expected text color to be nightRider for valid characters.")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "apple12345", "Text field value should be 'apple12345' after inputting 10 characters.")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "limitBorder-color-systemBlue", "Expected border color to be systemBlue, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        XCTAssertEqual(characterCountLabel.label, "0", "Expected character count label to be '0' after inputting exactly 10 characters.")
        XCTAssertEqual(characterCountLabel.value as? String, "limitCharacterCountLabel-color-nightRider", "Expected character count color to be nightRider, but found \(characterCountLabel.value ?? "nil").")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "limitBorder-color-fieldGray", "Expected border color to remain fieldGray after editing ends.")
    }
}
