import XCTest
@testable import TextFields

class TestLimitViewTextField: XCTestCase {
    var limitView: LimitView!
    
    // MARK: - Setup
    // Initialize LimitView with a character limit of 10
    override func setUpWithError() throws {
        limitView = LimitView(10)
    }
    
    // MARK: - Tests
    func testLimitViewTextField() {
        // Define test cases for different input scenarios
        let testCases = [
            (input: "12345", expectedTextColor: UIColor.nightRider, expectedBorderColor: UIColor.systemBlue.cgColor, expectedRemainingCharacters: "5"),
            (input: "1234567890", expectedTextColor: UIColor.nightRider, expectedBorderColor: UIColor.systemBlue.cgColor, expectedRemainingCharacters: "0"),
            (input: "123456789012", expectedTextColor: UIColor.red, expectedBorderColor: UIColor.red.cgColor, expectedRemainingCharacters: "-2")
        ]
        
        let textField = limitView.testableTextField
        
        // MARK: - Iterate through test cases
        for (input, expectedTextColor, expectedBorderColor, expectedRemainingCharacters) in testCases {
            textField.text = "" // Reset text field before each test
            
            // MARK: - Simulate character input
            for character in input {
                let currentText = textField.text ?? ""
                let shouldChange = limitView.textField(
                    textField,
                    shouldChangeCharactersIn: NSRange(location: currentText.count, length: 0),
                    replacementString: String(character)
                )
                
                if shouldChange {
                    textField.text = currentText + String(character)
                    // Verify that the text color updates correctly as the input length changes
                    XCTAssertEqual(textField.textColor?.cgColor, expectedTextColor.cgColor)
                }
            }
            
            // MARK: - Verify visual feedback
            // Assert that the border color and remaining character count are correct
            XCTAssertEqual(limitView.backgroundView.layer.borderColor, expectedBorderColor)
            XCTAssertEqual(limitView.characterCountLabel.text, expectedRemainingCharacters)
        }
    }
}
