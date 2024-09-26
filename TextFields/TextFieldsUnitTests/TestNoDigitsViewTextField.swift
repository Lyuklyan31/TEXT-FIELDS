import XCTest
@testable import TextFields

class TestNoDigitsViewTextField: XCTestCase {

    // MARK: - Properties
    var noDigitsView: NoDigitsView!
    var textField: UITextField!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        noDigitsView = NoDigitsView()
        textField = noDigitsView.testableTextField
    }
    
    // MARK: - Helper Method
    private func simulateInput(_ input: String) {
        textField.text = ""
        for character in input {
            let replacementString = String(character)
            let currentText = textField.text ?? ""
            
            let shouldChange = noDigitsView.textField(
                textField,
                shouldChangeCharactersIn: NSRange(location: currentText.count, length: 0),
                replacementString: replacementString
            )
            
            if shouldChange {
                textField.text = currentText + replacementString
            }
        }
    }

    // MARK: - Tests

    // Test case: Input "1a2p3p4l5e" should result in "apple"
    func testInputWithDigitsAndLetters() {
        simulateInput("1a2p3p4l5e")
        XCTAssertEqual(textField.text, "apple", "Expected output: apple")
    }
    
    // Test case: Input "12345" should result in an empty string ""
    func testInputWithOnlyDigits() {
        simulateInput("12345")
        XCTAssertEqual(textField.text, "", "Expected output: empty string")
    }

    // Test case: Input "apple" should result in "apple"
    func testInputWithOnlyLetters() {
        simulateInput("apple")
        XCTAssertEqual(textField.text, "apple", "Expected output: apple")
    }
    
    // Test case: Input "a1b2c3d4" should result in "abcd"
    func testInputWithMixedCharacters() {
        simulateInput("a1b2c3d4")
        XCTAssertEqual(textField.text, "abcd", "Expected output: abcd")
    }
    
    // Test case: Input "abc!@#123" should result in "abc!@#"
    func testInputWithSpecialCharacters() {
        simulateInput("abc!@#123")
        XCTAssertEqual(textField.text, "abc!@#", "Expected output: abc!@#")
    }
}
