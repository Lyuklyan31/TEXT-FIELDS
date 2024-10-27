import XCTest
@testable import TextFields

class TestOnlyCharactersViewTextField: XCTestCase {
    
    // MARK: - Properties
    var onlyCharactersView: OnlyCharactersView!
    var textField: UITextField!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        onlyCharactersView = OnlyCharactersView()
        textField = onlyCharactersView.testableTextField
    }

    // MARK: - Helper Method
    private func simulateInput(_ input: String) {
        textField.text = ""
        for character in input {
            let replacementString = String(character)
            let currentText = textField.text ?? ""
            
            let shouldChange = onlyCharactersView.textField(
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
    
    // Test case: Input "abcde12345" should result in "abcde-12345"
    func testValidInputWithDigits() {
        simulateInput("abcde12345")
        XCTAssertEqual(textField.text, "abcde-12345", "Expected text: abcde-12345")
    }
    
    // Test case: Input "abcd1f2345" should result in "abcdf-2345"
    func testInvalidDigitInFirstSection() {
        simulateInput("abcd1f2345")
        XCTAssertEqual(textField.text, "abcdf-2345", "Expected text: abcdf-2345")
    }
    
    // Test case: Input "abcdefghrd" should result in "abcde-"
    func testNoDigitsInSecondSection() {
        simulateInput("abcdefghrd")
        XCTAssertEqual(textField.text, "abcde-", "Expected text: abcde-")
    }

    // Test case: Input "abcde-" should result in "abcde-"
    func testValidInputWithDash() {
        simulateInput("abcde-")
        XCTAssertEqual(textField.text, "abcde-", "Expected text: abcde-")
    }

    // Test case: Input "abcde123456" should result in "abcde-12345"
    func testInputExceedingLimit() {
        simulateInput("abcde123456")
        XCTAssertEqual(textField.text, "abcde-12345", "Expected text: abcde-12345")
    }
}
