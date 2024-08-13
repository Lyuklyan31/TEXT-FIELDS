//
//  CustomPasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit
import SafariServices

class LinkTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    
    private let prefix = "https://"
    private var typingTimer: Timer?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI and Constraints

    // Sets up the UI elements and their constraints
    private func setupUI() {
        
        // Configures the background view properties and constraints
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        // Configures the title label properties and constraints
        titleLabel.text = "Link"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
        }
        
        // Configures the text field properties and constraints
        textField.attributedPlaceholder = NSAttributedString(
            string: "www.example.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        backgroundView.addSubview(textField)
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(7)
        }
    }

    // MARK: - Text Field Actions
    
    // Called when text in the text field changes; starts a timer to check the link validity
    @objc private func textFieldDidChange(_ textField: UITextField) {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(checkForValidLink), userInfo: nil, repeats: false)
    }

    // Checks if the current text is a valid URL and opens it if valid
    @objc private func checkForValidLink() {
        guard let urlString = textField.text, !urlString.isEmpty else { return }
        var formattedString = urlString

        if !formattedString.lowercased().hasPrefix(prefix) {
            formattedString = prefix + formattedString
        }
        
        if let url = URL(string: formattedString), UIApplication.shared.canOpenURL(url) {
            openURLInSafariViewController(url: url)
        }
    }

    // Presents a Safari View Controller with the given URL
    private func openURLInSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            navigationController.present(safariViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension LinkTextField: UITextFieldDelegate {
    
    // Dismiss the keyboard when the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkForValidLink()
        return true
    }
    
    // Change border color when editing begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // Reset border color when editing ends
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
