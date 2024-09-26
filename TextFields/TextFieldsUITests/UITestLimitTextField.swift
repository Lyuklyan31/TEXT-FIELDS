import XCTest
@testable import TextFields

final class UITestLimitTextField: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

//    (input: "12345", expectedTextColor: UIColor.nightRider, expectedBorderColor: UIColor.systemBlue.cgColor, expectedRemainingCharacters: "5"),
//    (input: "1234567890", expectedTextColor: UIColor.nightRider, expectedBorderColor: UIColor.systemBlue.cgColor, expectedRemainingCharacters: "0"),
//    (input: "123456789012", expectedTextColor: UIColor.red, expectedBorderColor: UIColor.red.cgColor, expectedRemainingCharacters: "-2")
    
    @MainActor
        func testLimitTextFieldColorChange() throws {
            let app = XCUIApplication()
            app.launch()

            let textField = app.textFields["limitTextField"]
            XCTAssertTrue(textField.exists, "Text field should exist.")

            textField.tap()
            textField.typeText("123456789012")

            let expectedTextColor = UIColor.red
            let textColor = LimitView(10).textField.textColor
            XCTAssertEqual(textColor, expectedTextColor, "Text color should be \(expectedTextColor)")
        }

}
