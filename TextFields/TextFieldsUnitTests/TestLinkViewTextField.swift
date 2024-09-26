import XCTest
@testable import TextFields

class TestLinkViewTextField: XCTestCase {
    var linkView: LinkView!
    var textField: UITextField!
    
    // MARK: - Properties for URL Opening
    var openURLCalled = false
    var openedURL: URL?

    // MARK: - Setup
    override func setUpWithError() throws {
        linkView = LinkView() // Initialize LinkView
        textField = linkView.testableTextField
        
        linkView.openURLAction = { [weak self] url in
            self?.openURLCalled = true
            self?.openedURL = url
        }
    }
    
    override func tearDownWithError() throws {
        openURLCalled = false
        openedURL = nil
    }
    
    // MARK: - Helper Method
    private func reset() {
        openURLCalled = false
        openedURL = nil
        textField.text = ""
    }

    // MARK: - Test Case 1: Valid URL with https://
    func testValidURLWithHttps() {
        textField.text = "https://www.wikipedia.org"
        linkView.textFieldDidChange(textField)
        
        let expectation1 = expectation(description: "URL should be opened for valid URL with https:// prefix.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertTrue(self.openURLCalled, "URL should have been opened for a valid URL with https:// prefix.")
            XCTAssertEqual(self.openedURL?.absoluteString, "https://www.wikipedia.org", "The URL opened should match the input.")
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 2.0)
    }
    
    // MARK: - Test Case 2: Valid URL without https://
    func testValidURLWithoutHttps() {
        reset()
        
        textField.text = "www.google.com"
        linkView.textFieldDidChange(textField)
        
        let expectation2 = expectation(description: "URL should be opened for valid URL without https:// prefix.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertTrue(self.openURLCalled, "URL should have been opened for valid URL without https://.")
            XCTAssertEqual(self.openedURL?.absoluteString, "https://www.google.com", "The URL should be opened with https:// prefix added.")
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 2.0)
    }
    
    // MARK: - Test Case 3: Empty Text
    func testEmptyTextDoesNotOpenURL() {
        reset()
        
        textField.text = ""
        linkView.textFieldDidChange(textField)
        
        let expectation3 = expectation(description: "Empty text should not trigger URL opening.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            XCTAssertFalse(self.openURLCalled, "Empty text should not trigger URL opening.")
            expectation3.fulfill()
        }
        wait(for: [expectation3], timeout: 2.0)
    }
}
