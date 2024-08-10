//
//  CustomePasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit
import WebKit

class CustomLinkTextField: UIView {

    // MARK: - UI Elements

    private let backgroundTextField = UIView()
    private let textField = UITextField()
    private let titleTextField = UILabel()
    private let prefix = "https://"

    private var hasTextChanged = false
    private var webView: WKWebView!

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }

    // MARK: - Setup Methods

    private func setupCustomTextField() {
        // Title Label
        titleTextField.text = "Link"
        titleTextField.font = UIFont.setFont(.rubikRegular, size: 13)
        titleTextField.textColor = UIColor.nightRider
        self.addSubview(titleTextField)
        
        // Background View
        backgroundTextField.backgroundColor = UIColor.fieldGray
        backgroundTextField.layer.cornerRadius = 11
        backgroundTextField.layer.borderWidth = 1.0
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        self.addSubview(backgroundTextField)
        
        // Text Field
        textField.attributedPlaceholder = NSAttributedString(
            string: "www.example.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        backgroundTextField.addSubview(textField)
        
        // Setting Constraints
        titleTextField.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        backgroundTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }

    // MARK: - Text Field Actions

    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}

// MARK: - UITextFieldDelegate

extension CustomLinkTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string.isEmpty {
            return true
        } else if string == UIPasteboard.general.string {
            handlePasteAction(textField: textField)
            return false
        }

        hasTextChanged = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let urlString = textField.text, !urlString.isEmpty {
            var formattedString = urlString
            // Add "https://" if not already present
            if !formattedString.lowercased().hasPrefix(prefix) {
                formattedString = prefix + formattedString
            }
            
            if let url = URL(string: formattedString) {
                openURLInWebView(url: url)
            }
        }
        return true
    }
    
    private func handlePasteAction(textField: UITextField) {
        guard let pastedText = UIPasteboard.general.string, !pastedText.isEmpty else { return }
        
        // Format pasted text
        var formattedString = pastedText
        
        // Remove any leading "https://" or "http://"
        if formattedString.lowercased().hasPrefix(prefix) {
            formattedString.removeFirst(prefix.count)
        } else if formattedString.lowercased().hasPrefix("http://") {
            formattedString.removeFirst("http://".count)
        }
        
        // Add "https://" if not already present
        formattedString = prefix + formattedString
        
        // Update the textField text without showing "https://"
        textField.text = formattedString
        
        if let url = URL(string: formattedString) {
            openURLInWebView(url: url)
        }
    }
}

// MARK: - WebView Handling

extension CustomLinkTextField: WKNavigationDelegate {
    private func openURLInWebView(url: URL) {
        let webViewController = UIViewController()
        webView = WKWebView()
        webView.navigationDelegate = self
        
        webViewController.view = webView
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            navigationController.pushViewController(webViewController, animated: true)
        }
    }
}
