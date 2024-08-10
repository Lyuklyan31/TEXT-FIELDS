//
//  CustomNoDigitsTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomNoDigitsTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let background = UIView()
    private let titleTextField = UILabel()

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
        // Configure title label
        titleTextField.text = "NO digits field"
        titleTextField.font = UIFont.setFont(.rubikRegular, size: 13)
        titleTextField.textColor = UIColor.nightRider
        self.addSubview(titleTextField)
        
        // Configure text field
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
       
        // Configure background view
        background.backgroundColor = UIColor.fieldGray
        background.layer.cornerRadius = 11
        background.layer.borderWidth = 1.0
        background.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor

        self.addSubview(background)
        background.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }

        background.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(7)
        }

        textField.delegate = self

        // Configure title label constraints
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalTo(background.snp.top).offset(-4)
        }
    }
    
    // MARK: - Public Methods
    
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }

    func setBorderColor(_ color: UIColor) {
        background.layer.borderColor = color.cgColor
    }
}

// MARK: - UITextFieldDelegate

extension CustomNoDigitsTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only non-digit characters
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard when return key is pressed
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Highlight border when editing begins
        setBorderColor(.systemBlue)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Restore border color when editing ends
        setBorderColor(UIColor(.fieldGray.opacity(0.12)))
    }
}
