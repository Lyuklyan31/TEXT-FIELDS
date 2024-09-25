import XCTest
@testable import TextFields

class TextFieldsUnitTests: XCTestCase {
    var noDigitsView: NoDigitsView!
    var limitView: LimitView!
    
    override func setUpWithError() throws {
        noDigitsView = NoDigitsView()
        limitView = LimitView(10)
    }
   
    func testTextFieldNoDigits() {
        let input = "1a2p3p4l5e"
        let expectedOutput = "apple"
        
        let textField = noDigitsView.testableTextField
        
        for character in input {
            let replacementString = String(character)
            let currentText = textField.text ?? ""
            let shouldChange = noDigitsView.textField(textField, shouldChangeCharactersIn: NSRange(location: currentText.count, length: 0), replacementString: replacementString)
            
            if shouldChange {
                textField.text = currentText + replacementString
            }
        }
        XCTAssertEqual(textField.text, expectedOutput, "TextField should block digits")
    }
}
