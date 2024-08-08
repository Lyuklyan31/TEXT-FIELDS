//
//  CustomePasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomePasswordTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundTextField = UIView()
    private let titleTextField = UILabel()
    private let lineExecution = UIView()
    
    private let minLength8Characters = UILabel()
    private let min1Digit = UILabel()
    private let min1Lowercase = UILabel()
    private let min1CapitalRequired = UILabel()
    
    private var lineWidthConstraint: Constraint?
    
    // MARK: - Properties
    
    private let initialText = ""
    private var hasTextChanged = false
    
    // MARK: - Initialization
    
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
        titleTextField.text = "Validation rules"
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
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.isSecureTextEntry = true
        backgroundTextField.addSubview(textField)
        
        // Line View
        lineExecution.backgroundColor = .clear
        lineExecution.layer.cornerRadius = 3
        self.addSubview(lineExecution)
        
        // Requirements Labels
        minLength8Characters.text = "- minimum of 8 characters."
        minLength8Characters.textColor = UIColor.matterhorn
        minLength8Characters.font = UIFont.setFont(.rubikRegular, size: 13)
        self.addSubview(minLength8Characters)
        
        min1Digit.text = "- minimum 1 digit"
        min1Digit.textColor = UIColor.matterhorn
        min1Digit.font = UIFont.setFont(.rubikRegular, size: 13)
        self.addSubview(min1Digit)
        
        min1Lowercase.text = "- minimum 1 lowercase"
        min1Lowercase.textColor = UIColor.matterhorn
        min1Lowercase.font = UIFont.setFont(.rubikRegular, size: 13)
        self.addSubview(min1Lowercase)
        
        min1CapitalRequired.text = "- minimum 1 capital required."
        min1CapitalRequired.textColor = UIColor.matterhorn
        min1CapitalRequired.font = UIFont.setFont(.rubikRegular, size: 13)
        self.addSubview(min1CapitalRequired)
        
        // Setting Constraints
        
        // Title Label Constraints
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
        }
        
        // Background View Constraints
        backgroundTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        // Text Field Constraints
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        // Line View Constraints
        lineExecution.snp.makeConstraints { make in
            make.top.equalTo(backgroundTextField.snp.bottom).offset(-9)
            make.leading.equalToSuperview().inset(-0.45)
            make.height.equalTo(9)
            self.lineWidthConstraint = make.width.equalTo(0).constraint
        }
        
        // Minimum Length Label Constraints
        minLength8Characters.snp.makeConstraints { make in
            make.top.equalTo(lineExecution.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        // Minimum Digit Label Constraints
        min1Digit.snp.makeConstraints { make in
            make.top.equalTo(minLength8Characters.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        // Minimum Lowercase Label Constraints
        min1Lowercase.snp.makeConstraints { make in
            make.top.equalTo(min1Digit.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        // Minimum Capital Label Constraints
        min1CapitalRequired.snp.makeConstraints { make in
            make.top.equalTo(min1Lowercase.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        setupTextFieldDelegate()
    }
    
    private func setupTextFieldDelegate() {
        // Set the textField delegate and add target for text changes
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Handle return key to dismiss keyboard
        textField.returnKeyType = .done
    }
    
    // MARK: - Text Field Handlers
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        hasTextChanged = true
        updateLineProgress()
    }
    
    private func updateLineProgress() {
        let text = textField.text ?? ""
        let conditions: [(UILabel, Bool)] = [
            (minLength8Characters, text.count >= 8),
            (min1Digit, text.rangeOfCharacter(from: .decimalDigits) != nil),
            (min1Lowercase, text.rangeOfCharacter(from: .lowercaseLetters) != nil),
            (min1CapitalRequired, text.rangeOfCharacter(from: .uppercaseLetters) != nil)
        ]
        
        let completedConditions = conditions.filter { $0.1 }.count
        
        // Оновлення міток і прогресу
        for (label, isMet) in conditions {
            isMet ? setConditionMet(label: label) : resetCondition(label: label)
        }
        
        let progress = CGFloat(completedConditions) / CGFloat(conditions.count)
        let color: UIColor
        
        switch completedConditions {
        case 1:
            color = .red
        case 2:
            color = .orange
        case 3:
            color = .orange
        case 4:
            color = .forestGreen
        default:
            color = .clear
        }
        
        lineExecution.backgroundColor = color
        lineWidthConstraint?.update(offset: self.frame.width * progress)
    }
    
    private func setConditionMet(label: UILabel) {
        let checkmark = "✔︎"
        
        if let text = label.text, !text.hasPrefix(checkmark) {
            let newText = text.replacingOccurrences(of: "-", with: checkmark)
            let attributedString = NSMutableAttributedString(string: newText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.forestGreen, range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
    }
    
    private func resetCondition(label: UILabel) {
        let checkmark = "✔︎"
        let hyphen = "-"
        
        if let text = label.text, text.hasPrefix(checkmark) {
            let newText = text.replacingOccurrences(of: checkmark, with: hyphen)
            let attributedString = NSMutableAttributedString(string: newText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.matterhorn, range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
    }
}

// MARK: - UITextFieldDelegate

extension CustomePasswordTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard when return key is pressed
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Handle when text field begins editing
        if textField.text?.isEmpty ?? true {
            textField.text = initialText
        }
        backgroundTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Handle when text field ends editing
        if !hasTextChanged {
            textField.text = ""
        }
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
