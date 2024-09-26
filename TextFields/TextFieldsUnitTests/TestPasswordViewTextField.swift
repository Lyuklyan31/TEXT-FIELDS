import XCTest
@testable import TextFields

class TestPasswordViewTextField: XCTestCase {

    // MARK: - Properties
    var passwordView: PasswordView!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        passwordView = PasswordView()
    }

    // MARK: - Test Method
    func testPasswordViewTextField() {
        let testCases: [(input: String, expectedProgressLineColor: UIColor, widthProgressLine: CGFloat, expectedAppearance: (digit: (UIColor, String), uppercase: (UIColor, String), lowercase: (UIColor, String), length: (UIColor, String)))] = [
            ("", UIColor.clear, 0.0, ((UIColor.matterhorn, "- minimum 1 digit"), (UIColor.matterhorn, "- minimum 1 capital letter."), (UIColor.matterhorn, "- minimum 1 lowercase"), (UIColor.matterhorn, "- minimum of 8 characters."))),
            ("1", UIColor.darkRed, 0.25, ((UIColor.darkGreen, "✔︎ minimum 1 digit"), (UIColor.matterhorn, "- minimum 1 capital letter."), (UIColor.matterhorn, "- minimum 1 lowercase"), (UIColor.matterhorn, "- minimum of 8 characters."))),
            ("1P", UIColor.darkOrange, 0.5, ((UIColor.darkGreen, "✔︎ minimum 1 digit"), (UIColor.darkGreen, "✔︎ minimum 1 capital letter."), (UIColor.matterhorn, "- minimum 1 lowercase"), (UIColor.matterhorn, "- minimum of 8 characters."))),
            ("1Pa", UIColor.darkOrange, 0.75, ((UIColor.darkGreen, "✔︎ minimum 1 digit"), (UIColor.darkGreen, "✔︎ minimum 1 capital letter."), (UIColor.darkGreen, "✔︎ minimum 1 lowercase"), (UIColor.matterhorn, "- minimum of 8 characters."))),
            ("1Password", UIColor.darkGreen, 1.0, ((UIColor.darkGreen, "✔︎ minimum 1 digit"), (UIColor.darkGreen, "✔︎ minimum 1 capital letter."), (UIColor.darkGreen, "✔︎ minimum 1 lowercase"), (UIColor.darkGreen, "✔︎ minimum of 8 characters.")))
        ]
        
        let textField = passwordView.testableTextField
        
        // Iterate through test cases
        for (input, expectedProgressLineColor, widthProgressLine, expectedAppearance) in testCases {
            textField.text = ""
            
            // Simulate character input
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
            
            // Verify the appearance and constraints
            XCTAssertEqual(passwordView.digitRequirementLabel.textColor, expectedAppearance.digit.0, "Wrong digit color")
            XCTAssertEqual(passwordView.digitRequirementLabel.text, expectedAppearance.digit.1, "Wrong digit text")

            XCTAssertEqual(passwordView.uppercaseRequirementLabel.textColor, expectedAppearance.uppercase.0, "Wrong uppercase color")
            XCTAssertEqual(passwordView.uppercaseRequirementLabel.text, expectedAppearance.uppercase.1, "Wrong uppercase text")

            XCTAssertEqual(passwordView.lowercaseRequirementLabel.textColor, expectedAppearance.lowercase.0, "Wrong lowercase color")
            XCTAssertEqual(passwordView.lowercaseRequirementLabel.text, expectedAppearance.lowercase.1, "Wrong lowercase text")

            XCTAssertEqual(passwordView.lengthRequirementLabel.textColor, expectedAppearance.length.0, "Wrong length color")
            XCTAssertEqual(passwordView.lengthRequirementLabel.text, expectedAppearance.length.1, "Wrong length text")

            XCTAssertEqual(passwordView.progressLine.backgroundColor, expectedProgressLineColor, "Wrong progress line color")

            let expectedWidth = passwordView.frame.width * widthProgressLine
            XCTAssertEqual(passwordView.lineWidthConstraint?.layoutConstraints.first?.constant, expectedWidth, "Wrong progress line width")

        }
    }
}
