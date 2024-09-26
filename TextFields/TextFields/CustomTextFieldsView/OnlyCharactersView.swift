//
//  CustomOnlyCharactersTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class OnlyCharactersView: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    
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
    
    private func setupUI() {
        // Configure titleLabel
        titleLabel.text = "Only characters"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        // Configure backgroundView
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        // Configure textField
        textField.attributedPlaceholder = NSAttributedString(
            string: "wwwww-ddddd",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        backgroundView.addSubview(textField)
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(7)
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

extension OnlyCharactersView: UITextFieldDelegate {
    
    // Validates the input against the regular expression
    private func isValidInput(_ text: String) -> Bool {
        let pattern = "^[a-zA-Zа-яА-ЯіІєЄ]{1,5}(-[0-9]{0,5})?$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: text)
    }

    // Handles text changes and enforces input rules
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Allow deletion if string is empty and range length is greater than 0
        if string.isEmpty && range.length > 0 { return true }
        
        // Restrict total length to 11 characters
        if newText.count > 11 { return false }
        
        // Validate input and handle formatting
        if isValidInput(newText) {
            if newText.count == 5 && !newText.contains("-") {
                textField.text = newText + "-"
                return false
            }
            return true
        }
        return false
    }

    // Dismisses the keyboard when the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Changes the border color when editing begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // Resets the border color when editing ends
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
