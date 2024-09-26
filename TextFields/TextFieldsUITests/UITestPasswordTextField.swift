//
//  UITestPasswordTextField.swift
//  TextFieldsUITests
//
//  Created by Mac on 26.09.2024.
//

import XCTest

final class UITestPasswordTextField: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - TEST N1:
    @MainActor
    func testPasswordTextField() throws {
        let textField = app.textFields["passwordTextField"]
        XCTAssertTrue(textField.exists, "Text field should exist.")
        
        let characterCountLabel = app.staticTexts["passwordCharacterCountLabel"]
        XCTAssertTrue(characterCountLabel.exists, "Character count label should exist.")
        
        let backgroundView = app.otherElements["passwordBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "Background view should exist.")
        
        textField.tap()
        textField.typeText("123456789012")
        
        let colorLabel = textField.label
        XCTAssertEqual(colorLabel, "passwordTextFieldText-color-red", "Expected text color to be red for characters beyond the limit.")
        
        // Verify the text field value
        XCTAssertEqual(textField.value as? String, "123456789012", "Text field value should be '123456789012' after inputting 12 characters.")
        
        // Verify border color
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "passwordBorder-color-red", "Expected border color to be red, but found \(borderColor ?? "nil").")
        
        // Verify character count label
        XCTAssertEqual(characterCountLabel.label, "-2", "Expected character count label to be '-2' after exceeding limit.")
        XCTAssertEqual(characterCountLabel.value as? String, "passwordCharacterCountLabel-color-red", "Expected character count color to be red after exceeding limit.")
        
        app.tap() // Dismiss the keyboard
        XCTAssertEqual(backgroundView.value as? String, "passwordBorder-color-red", "Expected border color to remain red after editing ends.")
    }
}
