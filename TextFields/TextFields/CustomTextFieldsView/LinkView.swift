//
//  CustomPasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit
import SafariServices

class LinkView: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    
    private let prefix = "https://"
    private var typingTimer: Timer?
    
    var openURLAction: ((URL) -> Void)?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupUI()
        openURLAction = openURLInSafariViewController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI and Constraints
    
    private func setupUI() {
        // Configure title label
        titleLabel.text = "Link"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        // Configure background view
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        backgroundView.accessibilityIdentifier = "linkBackgroundView"
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        // Configure text field
        textField.attributedPlaceholder = NSAttributedString(
            string: "www.example.com",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        backgroundView.addSubview(textField)
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.accessibilityIdentifier = "linkTextField"
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(7)
        }
    }

    // MARK: - Text Field Actions
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Invalidate the previous timer and start a new one
        typingTimer?.invalidate()
        typingTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(checkForValidLink), userInfo: nil, repeats: false)
    }

    @objc private func checkForValidLink() {
        guard let urlString = textField.text, !urlString.isEmpty else { return }
        var formattedString = urlString
        
        if !formattedString.lowercased().hasPrefix(prefix) {
            formattedString = prefix + formattedString
        }
        
        if let url = URL(string: formattedString), UIApplication.shared.canOpenURL(url) {
            openURLAction?(url)
            openURLInSafariViewController(url: url)
        }
    }

    private func openURLInSafariViewController(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        
        // Спробуємо отримати доступ до поточної сцени
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            
            // Задаємо ідентифікатор для відстеження
            safariViewController.view.accessibilityIdentifier = "SafariViewController"
            
            navigationController.present(safariViewController, animated: true, completion: nil)
        }
    }

    // Testable Access for Unit Tests
    #if DEBUG
    var testableTextField: UITextField {
        return textField
    }
    #endif
}

// MARK: - UITextFieldDelegate

extension LinkView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkForValidLink()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
        backgroundView.accessibilityValue = "linkBorder-color-systemBlue"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        backgroundView.accessibilityValue = "linkBorder-color-fieldGray"
    }
}

