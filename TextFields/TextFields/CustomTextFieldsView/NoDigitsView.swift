//
//  CustomNoDigitsTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class NoDigitsView: UIView {
    
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
        // Setup title label
        titleLabel.text = "NO digits field"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        // Setup background view
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
        
        // Setup text field
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        
        backgroundView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(7)
        }
    }
    // MARK: - Testable Access for Unit Tests
    #if DEBUG
    var testableTextField: UITextField {
        return textField
    }
    #endif
}

// MARK: - UITextFieldDelegate

extension NoDigitsView: UITextFieldDelegate {
    
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

#Preview() {
    NoDigitsView()
}
