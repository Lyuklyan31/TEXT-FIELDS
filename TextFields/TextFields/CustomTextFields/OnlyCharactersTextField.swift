//
//  CustomOnlyCharactersTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class OnlyCharactersTextField: UIView {
    
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
        // Configure backgroundView
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        // Configure titleLabel
        titleLabel.text = "Only characters"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        // Configure textField
        textField.attributedPlaceholder = NSAttributedString(
            string: "wwwww-ddddd",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        backgroundView.addSubview(textField)
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
    }
}

// MARK: - UITextFieldDelegate

extension OnlyCharactersTextField: UITextFieldDelegate {
   
    // Checks if the input matches the regular expression
    private func isValidInput(_ text: String) -> Bool {
        let pattern = "^[a-zA-Zа-яА-ЯіІєЄ]{1,5}(-[0-9]{0,5})?$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: text)
    }

    // Handles text changes and enforces input rules
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if string.isEmpty && range.length > 0 { return true }
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
