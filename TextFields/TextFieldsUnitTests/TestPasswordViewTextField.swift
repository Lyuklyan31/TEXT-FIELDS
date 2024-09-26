import XCTest
@testable import TextFields

class TestPasswordViewTextField: XCTestCase {

    // MARK: - Properties
    var passwordView: PasswordView!
    var textField: UITextField!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        passwordView = PasswordView()
        textField = passwordView.testableTextField
    }

    // MARK: - Helper Method
    private func simulateInput(_ input: String) {
        textField.text = ""
        for character in input {
            let currentText = textField.text ?? ""
            let shouldChange = passwordView.textField(
                textField,
                shouldChangeCharactersIn: NSRange(location: currentText.count, length: 0),
                replacementString: String(character)
            )
            
            if shouldChange {
                textField.text = currentText + String(character)
                passwordView.textFieldDidChange(textField)
            }
        }
    }

    // MARK: - Tests

    // Test that color for digits becomes green when a digit is entered
    func testDigitRequirementColor() {
        simulateInput("1")
        XCTAssertEqual(passwordView.digitRequirementLabel.textColor, UIColor.darkGreen, "Digit color should be green")
        XCTAssertEqual(passwordView.digitRequirementLabel.text, "✔︎ minimum 1 digit", "Incorrect digit requirement text")
    }

    // Test that color for uppercase letters becomes green when an uppercase letter is entered
    func testUppercaseRequirementColor() {
        simulateInput("P")
        XCTAssertEqual(passwordView.uppercaseRequirementLabel.textColor, UIColor.darkGreen, "Uppercase color should be green")
        XCTAssertEqual(passwordView.uppercaseRequirementLabel.text, "✔︎ minimum 1 capital letter.", "Incorrect uppercase requirement text")
    }

    // Test that color for lowercase letters becomes green when a lowercase letter is entered
    func testLowercaseRequirementColor() {
        simulateInput("a")
        XCTAssertEqual(passwordView.lowercaseRequirementLabel.textColor, UIColor.darkGreen, "Lowercase color should be green")
        XCTAssertEqual(passwordView.lowercaseRequirementLabel.text, "✔︎ minimum 1 lowercase", "Incorrect lowercase requirement text")
    }

    // Test that color for length becomes green when password length is at least 8 characters
    func testLengthRequirementColor() {
        simulateInput("Password1")
        XCTAssertEqual(passwordView.lengthRequirementLabel.textColor, UIColor.darkGreen, "Length color should be green")
        XCTAssertEqual(passwordView.lengthRequirementLabel.text, "✔︎ minimum of 8 characters.", "Incorrect length requirement text")
    }
}
