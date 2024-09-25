//
//  CustomPasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class PasswordView: UIView {

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

    private func setupUI() {
        // Configure titleLabel
        titleLabel.text = "Validation rules"
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
        }
        
        // Configure textField
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.isSecureTextEntry = true
        
        backgroundView.addSubview(textField)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.returnKeyType = .done
        
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(7)
        }
        
        // Configure progressLine
        progressLine.backgroundColor = .clear
        progressLine.layer.cornerRadius = 1
        
        addSubview(progressLine)
        progressLine.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(-0.45)
            $0.height.equalTo(8)
            self.lineWidthConstraint = $0.width.equalTo(0).constraint
        }
        
        // Configure stackView
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
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(progressLine.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
    }

    // MARK: - Text Field Handlers

    @objc private func textFieldDidChange(_ textField: UITextField) {
        hasTextChanged = true
        updateLineProgress()
    }

    private func updateLineProgress() {
        let text = textField.text ?? ""

        // Define validation conditions
        let conditions: [(UILabel, Bool)] = [
            (lengthRequirementLabel, text.count >= 8),
            (digitRequirementLabel, text.rangeOfCharacter(from: .decimalDigits) != nil),
            (lowercaseRequirementLabel, text.rangeOfCharacter(from: .lowercaseLetters) != nil),
            (uppercaseRequirementLabel, text.rangeOfCharacter(from: .uppercaseLetters) != nil)
        ]

        let completedConditions = conditions.filter { $0.1 }.count

        // Update labels based on conditions
        conditions.forEach { label, isMet in
            updateCondition(label: label, isMet: isMet)
        }

        let progress = CGFloat(completedConditions) / CGFloat(conditions.count)

        // Define color based on completed conditions
        let colors: [Int: UIColor] = [
            1: .darkRed,
            2: .darkOrange,
            3: .darkOrange,
            4: .darkGreen
        ]
        let color = colors[completedConditions] ?? .clear

        // Update progress line color and width
        progressLine.backgroundColor = color
        lineWidthConstraint?.update(offset: self.frame.width * progress)
    }

    private func updateCondition(label: UILabel, isMet: Bool) {
        let checkmark = "✔︎"
        let hyphen = "-"
        
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

extension PasswordView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = initialText
        }
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !hasTextChanged {
            textField.text = ""
        }
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
