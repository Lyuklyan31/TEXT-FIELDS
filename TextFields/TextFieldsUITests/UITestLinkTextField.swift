import XCTest
@testable import TextFields

final class TestLinkTextField: XCTestCase {
    
    // MARK: - Properties
    var app: XCUIApplication!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch() // Launching the app
    }
    
    // MARK: - Test Cases

    // MARK:  Test N1 - Valid URL with HTTPS
    func testValidURLWithHTTPS() {
        let textField = app.textFields["linkTextField"]
        XCTAssertTrue(textField.exists, "The link text field should exist.")
        
        let backgroundView = app.otherElements["linkBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "The background view should exist.")
        
        textField.tap()
        textField.typeText("https://www.wikipedia.org")
        
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "linkBorder-color-systemBlue", "Expected border color to be systemBlue after typing.")
        
        app.tap() // Simulating user tapping outside
        
        let validColor = backgroundView.value as? String
        XCTAssertEqual(validColor, "linkBorder-color-fieldGray", "Expected border color to be fieldGray after typing valid URL.")
        
        let expectation = self.expectation(description: "Waiting for the URL to open.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let safariViewController = self.app.otherElements["SafariViewController"]
            XCTAssertTrue(safariViewController.exists, "Safari View Controller did not open.")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 6.0)
    }

    // MARK: - Test N2 - Empty Text
    func testEmptyText() {
        let textField = app.textFields["linkTextField"]
        XCTAssertTrue(textField.exists, "The link text field should exist.")
        
        let backgroundView = app.otherElements["linkBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "The background view should exist.")
        
        textField.tap()
        textField.typeText("")
        
        let borderColor = backgroundView.value as? String
        XCTAssertEqual(borderColor, "linkBorder-color-systemBlue", "Expected border color to be systemBlue, but got \(borderColor ?? "nil").")
        
        app.tap() // Simulating user tapping outside
        XCTAssertEqual(backgroundView.value as? String, "linkBorder-color-fieldGray", "Expected border color to be fieldGray after empty input.")
        
        let expectation = self.expectation(description: "Empty text should not trigger opening.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertFalse(self.app.otherElements["urlOpened"].exists, "Empty text should not trigger URL opening.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    // MARK: - Test N3 - Valid URL without HTTPS
    func testValidURLWithoutHTTPS() {
        let textField = app.textFields["linkTextField"]
        XCTAssertTrue(textField.exists, "The link text field should exist.")
        
        let backgroundView = app.otherElements["linkBackgroundView"]
        XCTAssertTrue(backgroundView.exists, "The background view should exist.")
        
        textField.tap()
        textField.typeText("www.google.com")
        
        let initialBorderColor = backgroundView.value as? String
        XCTAssertEqual(initialBorderColor, "linkBorder-color-systemBlue", "Expected border color to be systemBlue after typing.")
        
        app.tap() // Simulating user tapping outside
        
        let validColor = backgroundView.value as? String
        XCTAssertEqual(validColor, "linkBorder-color-fieldGray", "Expected border color to be fieldGray after typing valid URL.")
        
        let expectation = self.expectation(description: "Waiting for the URL to open.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let safariViewController = self.app.otherElements["SafariViewController"]
            XCTAssertTrue(safariViewController.exists, "Safari View Controller did not open.")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 6.0)
    }
}
