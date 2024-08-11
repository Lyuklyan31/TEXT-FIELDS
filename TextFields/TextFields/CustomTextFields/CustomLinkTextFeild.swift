//
//  CustomPasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit
import SafariServices

class CustomLinkTextField: UIView {
    
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
    
    // MARK: - Setup Methods
    
    // SetupUI
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        
        setupTitleLabel()
        setupBackgroundView()
        setupTextField()
    }
    
    // SetupTitleLabel
    private func setupTitleLabel() {
        titleLabel.text = "Link"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
        }
    }
    
    // SetupBackgroundView
    private func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    // SetupTextField
    private func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "www.example.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(7)
        }
    }
    
    // MARK: - SetBorderColor
    
    func setBorderColor(_ color: UIColor) {
        backgroundView.layer.borderColor = color.cgColor
    }
    
    // MARK: - Text Field Actions
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(checkForValidLink), userInfo: nil, repeats: false)
    }

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
    
    private func openURLInSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            navigationController.present(safariViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension CustomLinkTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkForValidLink()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setBorderColor(.systemBlue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setBorderColor(UIColor(.fieldGray.opacity(0.12)))
    }
}
