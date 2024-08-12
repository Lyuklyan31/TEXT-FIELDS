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
    
    // Method to set up the overall UI elements and layout
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        
        setupTitleLabel()
        setupBackgroundView()
        setupTextField()
    }
    
    // Method to set up the title label properties and constraints
    private func setupTitleLabel() {
        titleLabel.text = "NO digits field"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
        }
    }
    
    // Method to set up the background view properties and constraints
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
    
    // Method to set up the text field properties and constraints
    private func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(7)
        }
    }
}

// MARK: - UITextFieldDelegate

extension CustomNoDigitsTextField: UITextFieldDelegate {
    
    // Filters out numeric characters from the input and updates the text field manually.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return false }
        textField.text = text.replacingCharacters(in: range, with: string).filter { !$0.isNumber }
        return false
    }
    
    // Dismisses the keyboard when the return key is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Change border color when editing begins.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }
        
    // Reset border color when editing ends.
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
