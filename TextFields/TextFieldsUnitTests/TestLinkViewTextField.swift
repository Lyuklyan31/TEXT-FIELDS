import XCTest
@testable import TextFields

class TestLinkViewTextField: XCTestCase {
    var linkView: LinkView!
    
    // MARK: - Setup
    override func setUpWithError() throws {
        linkView = LinkView() // Initialize LinkView
    }
    
    // MARK: - Tests
    func testLinkViewTextField() {
        let textField = linkView.testableTextField
        
        // MARK: - Test Variables
        var openURLCalled = false
        var openedURL: URL?
        
        // MARK: - Setup Action
        linkView.openURLAction = { url in
            openURLCalled = true
            openedURL = url
        }
        
        // MARK: - Test Case 1: Valid URL with https://
        textField.text = "https://www.wikipedia.org"
        linkView.textFieldDidChange(textField)
        
        let expectation1 = expectation(description: "URL should be opened for valid URL with https:// prefix.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertTrue(openURLCalled, "URL should have been opened for a valid URL with https:// prefix.")
            XCTAssertEqual(openedURL?.absoluteString, "https://www.wikipedia.org", "The URL opened should match the input.")
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 2.0)
        
        // MARK: - Test Case 2: Valid URL without https://
        textField.text = ""
        openURLCalled = false
        openedURL = nil
        
        textField.text = "www.google.com"
        linkView.textFieldDidChange(textField)
        
        let expectation2 = expectation(description: "URL should be opened for valid URL without https:// prefix.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertTrue(openURLCalled, "URL should have been opened without 'https://'.")
            XCTAssertEqual(openedURL?.absoluteString, "https://www.google.com", "The URL should remain the same and not change.")
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 2.0)
        
        // MARK: - Reset for Next Test
        openURLCalled = false
        openedURL = nil
        
        // MARK: - Test Case 3: Empty Text
        textField.text = ""
        linkView.textFieldDidChange(textField)
        
        let expectation4 = expectation(description: "Empty text should not trigger opening.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertFalse(openURLCalled, "Empty text should not trigger opening.")
            expectation4.fulfill()
        }
        wait(for: [expectation4], timeout: 2.0)
    }
}
