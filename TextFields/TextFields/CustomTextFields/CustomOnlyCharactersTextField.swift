//
//  CustomOnlyCharactersTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomOnlyCharactersTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup Methods
    
    // SetupView
    private func setupView() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        
        setupTitleLabel()
        setupBackgroundView()
        setupTextField()
    }
    
    // SetupTitleLabel
    private func setupTitleLabel() {
        titleLabel.text = "Only characters"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
            make.leading.equalToSuperview()
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
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // SetupTextField
    private func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "wwwww-ddddd",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
    }
}

// MARK: - UITextFieldDelegate

extension CustomOnlyCharactersTextField: UITextFieldDelegate {
    
    // Checks if the text matches the allowed pattern
    private func isValidInput(_ text: String) -> Bool {
        let pattern = "^[a-zA-Zа-яА-ЯіІєЄ]{1,5}-?[0-9]{0,5}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: text)
    }
    
    // Handles text changes and enforces input rules
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Allow text deletion
        if string.isEmpty && range.length > 0 { return true }
        
        // Limit total length to 11 characters
        if newText.count > 11 { return false }
        
        // Validate and auto-insert a hyphen if needed
        if isValidInput(newText) {
            if newText.count == 5 && !newText.contains("-") {
                textField.text = newText + "-"
                return false
            }
            return true
        }
        return false
    }
    
    // Dismiss the keyboard when the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
