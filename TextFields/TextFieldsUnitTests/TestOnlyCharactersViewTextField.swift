import XCTest
@testable import TextFields

class TestOnlyCharactersViewTextField: XCTestCase {
    
    // MARK: - Properties
    var onlyCharactersView: OnlyCharactersView!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        onlyCharactersView = OnlyCharactersView()
    }
    
    // MARK: - Test Method
    func testOnlyCharactersViewTextField() {
        let testCases = [
            (input: "abcde12345",  expected: "abcde-12345"),
            (input: "abcd1f2345", expected: "abcdf-2345"),
            (input: "abcdefghrd", expected: "abcde-"),
            (input: "abcde-", expected: "abcde-"),
            (input: "abcde123456", expected: "abcde-12345")
        ]
        
        let textField = onlyCharactersView.testableTextField
        
        // Iterate over test cases
        for testCase in testCases {
            textField.text = ""
            
            // Simulate character input
            for character in testCase.input {
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
            
            // Assert the final text matches expected output
            XCTAssertEqual(textField.text, testCase.expected, "Expected textField to have text: \(testCase.expected) but found: \(String(describing: textField.text))")
        }
    }
}
