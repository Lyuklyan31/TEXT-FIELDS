//
//  CustomeLinkTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit
import WebKit

class CustomeLinkTextField: UIView {
    
    private let backgroundTextField = UIView()
    private let textField = UITextField()
    private let titleTextField = UILabel()
    private let initialText = "https://"
    
    private var hasTextChanged = false
    
    private var webView: WKWebView!
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }
    
    private func setupCustomTextField() {
        titleTextField.text = "Link"
        titleTextField.font = UIFont(name: "RubikRegular", size: 13)
        titleTextField.textColor = UIColor.nightRider
        
        backgroundTextField.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        textField.placeholder = "www.example.com"
        textField.font = UIFont(name: "RubikRegular", size: 17)
        textField.delegate = self
        
        backgroundTextField.backgroundColor = UIColor.fieldGray
        backgroundTextField.layer.cornerRadius = 11
        backgroundTextField.layer.borderWidth = 1.0
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        self.addSubview(backgroundTextField)
        
        backgroundTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundTextField.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(7)
        }
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = initialText
            hasTextChanged = false
        }
        backgroundTextField.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if !hasTextChanged {
            if textField.text == initialText {
                textField.text = ""
            }
        }
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}

extension CustomeLinkTextField: WKNavigationDelegate {
    private func openURLInWebView(url: URL) {
        let webViewController = UIViewController()
        let webView = WKWebView()
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
 
extension CustomeLinkTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        if newText.hasPrefix(initialText) {
            if newText.count < initialText.count {
                return false
            }
        }
        hasTextChanged = true
        return true
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let urlString = textField.text, !urlString.isEmpty {
            let formattedString = urlString.starts(with: "http://") || urlString.starts(with: "https://") ? urlString : "https://" + urlString
            if let url = URL(string: formattedString) {
                openURLInWebView(url: url)
            }
        }
        return true
    }
}
