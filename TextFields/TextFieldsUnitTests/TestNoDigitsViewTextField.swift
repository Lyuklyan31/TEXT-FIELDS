import XCTest
@testable import TextFields

class TestNoDigitsViewTextField: XCTestCase {

    // MARK: - Properties
    var noDigitsView: NoDigitsView!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        noDigitsView = NoDigitsView()
    }
    
    // MARK: - Test Method
    func testNoDigitsViewTextField() {
        let input = "1a2p3p4l5e"
        let expectedOutput = "apple"
        
        let textField = noDigitsView.testableTextField
        
        // Simulate character input
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
        
        // Assert final text after digits are blocked
        XCTAssertEqual(textField.text, expectedOutput, "TextField should block digits and allow only non-digit characters.")
    }
}
