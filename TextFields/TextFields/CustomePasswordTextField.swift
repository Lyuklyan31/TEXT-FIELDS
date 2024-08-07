//
//  CustomePasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomePasswordTextField: UIView {
    
    private let textField = UITextField()
    private let backgroundTextField = UIView()
    private let titleTextField = UILabel()
    private let lineExecution = UIView()
    
    private let minLength8Characters = UILabel()
    private let min1Digit = UILabel()
    private let min1Lowercase = UILabel()
    private let min1CapitalRequired = UILabel()
    
    private var lineWidthConstraint: Constraint?
    
    private let initialText = ""
    private var hasTextChanged = false
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupCustomTextField() {
        // Title Label
        titleTextField.text = "Validation rules"
        titleTextField.font = UIFont(name: "RubikRegular", size: 13)
        titleTextField.textColor = UIColor.nightRider
        self.addSubview(titleTextField)
        
        // Background View
        backgroundTextField.backgroundColor = UIColor.fieldGray
        backgroundTextField.layer.cornerRadius = 11
        backgroundTextField.layer.borderWidth = 1.0
        backgroundTextField.layer.borderColor = UIColor.fieldGray.withAlphaComponent(0.12).cgColor
        self.addSubview(backgroundTextField)
        
        // Text Field
        textField.placeholder = "Password"
        textField.font = UIFont(name: "RubikRegular", size: 17)
        textField.isSecureTextEntry = true
        backgroundTextField.addSubview(textField)
        
        // Line View
        lineExecution.backgroundColor = .clear
        self.addSubview(lineExecution)
        
        // Requirements Labels
        minLength8Characters.text = "Min length 8 characters."
        minLength8Characters.font = UIFont(name: "RubikRegular", size: 13)
        self.addSubview(minLength8Characters)
        
        min1Digit.text = "Min 1 digit"
        min1Digit.font = UIFont(name: "RubikRegular", size: 13)
        self.addSubview(min1Digit)
        
        min1Lowercase.text = "Min 1 lowercase"
        min1Lowercase.font = UIFont(name: "RubikRegular", size: 13)
        self.addSubview(min1Lowercase)
        
        min1CapitalRequired.text = "Min 1 capital required."
        min1CapitalRequired.font = UIFont(name: "RubikRegular", size: 13)
        self.addSubview(min1CapitalRequired)
        
        // Setting Constraints
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
        }
        
        backgroundTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        lineExecution.snp.makeConstraints { make in
            make.top.equalTo(backgroundTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.height.equalTo(4)
            self.lineWidthConstraint = make.width.equalTo(0).constraint
        }
        
        minLength8Characters.snp.makeConstraints { make in
            make.top.equalTo(lineExecution.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        min1Digit.snp.makeConstraints { make in
            make.top.equalTo(minLength8Characters.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        min1Lowercase.snp.makeConstraints { make in
            make.top.equalTo(min1Digit.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        min1CapitalRequired.snp.makeConstraints { make in
            make.top.equalTo(min1Lowercase.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = initialText
            hasTextChanged = false
        }
        backgroundTextField.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        if !hasTextChanged {
            if textField.text == initialText {
                textField.text = ""
            }
        }
        backgroundTextField.layer.borderColor = UIColor.fieldGray.withAlphaComponent(0.12).cgColor
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        hasTextChanged = true
        updateLineProgress()
    }
    
    private func updateLineProgress() {
        var completedConditions = 0
        
        if let text = textField.text {
            if text.count >= 8 {
                completedConditions += 1
                setConditionMet(label: minLength8Characters)
            } else {
                resetCondition(label: minLength8Characters)
            }
            
            if text.rangeOfCharacter(from: .decimalDigits) != nil {
                completedConditions += 1
                setConditionMet(label: min1Digit)
            } else {
                resetCondition(label: min1Digit)
            }
            
            if text.rangeOfCharacter(from: .lowercaseLetters) != nil {
                completedConditions += 1
                setConditionMet(label: min1Lowercase)
            } else {
                resetCondition(label: min1Lowercase)
            }
            
            if text.rangeOfCharacter(from: .uppercaseLetters) != nil {
                completedConditions += 1
                setConditionMet(label: min1CapitalRequired)
            } else {
                resetCondition(label: min1CapitalRequired)
            }
        }
        
        let progress = CGFloat(completedConditions) / 4.0
        var color: UIColor
        
        switch completedConditions {
        case 1:
            color = .red
        case 2:
            color = .orange
        case 3:
            color = .orange
        case 4:
            color = .green
        default:
            color = .clear
        }
        
        lineExecution.backgroundColor = color
        lineWidthConstraint?.update(offset: self.frame.width * progress)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setConditionMet(label: UILabel) {
        let checkmark = "✔︎ "
        
        if let text = label.text, !text.hasPrefix(checkmark) {
            let attributedString = NSMutableAttributedString(string: checkmark + text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
    }

    
    private func resetCondition(label: UILabel) {
        let text = label.text?.replacingOccurrences(of: "✔︎ ", with: "") ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
        label.attributedText = attributedString
    }
}
