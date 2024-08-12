//
//  CustomPasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class PasswordTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundView = UIView()
    private let titleLabel = UILabel()
    private let progressLine = UIView()
    private let stackView = UIStackView()
    
    private let lengthRequirementLabel = UILabel()
    private let digitRequirementLabel = UILabel()
    private let lowercaseRequirementLabel = UILabel()
    private let uppercaseRequirementLabel = UILabel()
    
    private var lineWidthConstraint: Constraint?
    
    // MARK: - Properties
    
    private let initialText = ""
    private var hasTextChanged = false
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI and Constraints
    
    // Adding subviews
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        addSubview(progressLine)
        addSubview(stackView)
        
        setupTitleLabel()
        setupBackgroundView()
        setupTextField()
        setupProgressLine()
        setupStackView()
    }
    
    // Title Label Configuration
    private func setupTitleLabel() {
        titleLabel.text = "Validation rules"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
        }
    }
    
    // Background View Configuration
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
    
    // Text Field Configuration
    private func setupTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.isSecureTextEntry = true
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
    }
    
    // Progress Line Configuration
    private func setupProgressLine() {
        progressLine.backgroundColor = .clear
        progressLine.layer.cornerRadius = 3
        
        progressLine.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(-9)
            make.leading.equalToSuperview().inset(-0.45)
            make.height.equalTo(9)
            self.lineWidthConstraint = make.width.equalTo(0).constraint
        }
    }
    
    // Stack View Configuration
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        
        let labels = [
            ("- minimum of 8 characters.", lengthRequirementLabel),
            ("- minimum 1 digit", digitRequirementLabel),
            ("- minimum 1 lowercase", lowercaseRequirementLabel),
            ("- minimum 1 capital letter.", uppercaseRequirementLabel)
        ]
        
        labels.forEach { text, label in
            label.text = text
            label.textColor = .matterhorn
            label.font = UIFont.setFont(.rubikRegular, size: 13)
            stackView.addArrangedSubview(label)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(progressLine.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - Text Field Handlers
    
    // Called when the text field's content changes
    @objc private func textFieldDidChange(_ textField: UITextField) {
        hasTextChanged = true
        updateLineProgress()  // Update progress line based on current text field content
    }
    
    // Updates the progress line and validation labels based on the text field's content
    private func updateLineProgress() {
        let text = textField.text ?? ""
        
        // Define the validation conditions for password strength
        let conditions: [(UILabel, Bool)] = [
            (lengthRequirementLabel, text.count >= 8),
            (digitRequirementLabel, text.rangeOfCharacter(from: .decimalDigits) != nil),
            (lowercaseRequirementLabel, text.rangeOfCharacter(from: .lowercaseLetters) != nil),
            (uppercaseRequirementLabel, text.rangeOfCharacter(from: .uppercaseLetters) != nil)
        ]
        
        let completedConditions = conditions.filter { $0.1 }.count
        
        // Update each label based on whether its condition is met
        conditions.forEach { label, isMet in
            updateCondition(label: label, isMet: isMet)
        }
        
        let progress = CGFloat(completedConditions) / CGFloat(conditions.count)
        
        // Define color based on the number of completed conditions
        let colors: [Int: UIColor] = [
            1: .darkRed,
            2: .darkOrange,
            3: .darkOrange,
            4: .darkGreen
        ]
        let color = colors[completedConditions] ?? .clear
        
        // Update the progress line color and width
        progressLine.backgroundColor = color
        lineWidthConstraint?.update(offset: self.frame.width * progress)
    }
    
    // Updates the text and color of a label based on whether its condition is met
    private func updateCondition(label: UILabel, isMet: Bool) {
        let checkmark = "✔︎"
        let hyphen = "-"
        
        // Determine the symbol and color based on whether the condition is met
        let (symbol, color) = isMet ? (checkmark, UIColor.darkGreen) : (hyphen, UIColor.matterhorn)
        
        if let text = label.text, text.contains(checkmark) != isMet {
            let newText = text.replacingOccurrences(of: isMet ? hyphen : checkmark, with: symbol)
            let attributedString = NSMutableAttributedString(string: newText)
            attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.length))
            label.attributedText = attributedString
        }
    }
}

// MARK: - UITextFieldDelegate

extension PasswordTextField: UITextFieldDelegate {
    
    // Called when the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the text field starts editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = initialText
        }
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // Called when the text field ends editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !hasTextChanged {
            textField.text = ""
        }
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
