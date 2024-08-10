//
//  CustomMaxSize10TextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class LimitTextField: UIView {
    
    // MARK: - UI Elements
    
    private let textField = UITextField()
    private let backgroundTextField = UIView()
    private let titleTextField = UILabel()
    private let maxSymbolsLabel = UILabel()
    
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
            // Title Label
            titleTextField.text = "Input limit"
            titleTextField.font = UIFont.setFont(.rubikRegular, size: 13)
            titleTextField.textColor = UIColor.nightRider
            self.addSubview(titleTextField)
            
            // Max Symbols Label
            maxSymbolsLabel.text = "10"
            maxSymbolsLabel.font = UIFont.setFont(.rubikRegular, size: 13)
            maxSymbolsLabel.textColor = UIColor.nightRider
            self.addSubview(maxSymbolsLabel)
            
            // Background View
            backgroundTextField.backgroundColor = UIColor.fieldGray
            backgroundTextField.layer.cornerRadius = 11
            backgroundTextField.layer.borderWidth = 1.0
            backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
            self.addSubview(backgroundTextField)
            
            // Text Field
            textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
            )
            textField.font = UIFont.setFont(.rubikRegular, size: 17)
            backgroundTextField.addSubview(textField)
            
            // Setting Constraints
            titleTextField.snp.makeConstraints { make in
                make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
                make.leading.equalToSuperview()
            }
            
            maxSymbolsLabel.snp.makeConstraints { make in
                make.bottom.equalTo(backgroundTextField.snp.top).offset(-7)
                make.trailing.equalToSuperview()
            }
            
            backgroundTextField.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(36)
                make.leading.trailing.equalToSuperview()
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
            }
            
            textField.delegate = self
        }

}
    // MARK: - UITextFieldDelegate
    
extension LimitTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        let newLength = newText.count
        
        let remainingCharacters = 10 - newLength

        if newLength <= 10 {
            // Update label and border color within limit (counting down)
            maxSymbolsLabel.text = "\(remainingCharacters)"
            maxSymbolsLabel.textColor = UIColor.nightRider
            backgroundTextField.layer.borderColor = UIColor.systemBlue.cgColor
            
            let attributedText = NSMutableAttributedString(string: newText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.nightRider, range: NSRange(location: 0, length: newLength))
            textField.attributedText = attributedText
        } else {
            // Update label and border color for exceeding limit (negative counting)
            maxSymbolsLabel.text = "-\(newLength - 10)"
            maxSymbolsLabel.textColor = .red
            backgroundTextField.layer.borderColor = UIColor.red.cgColor
            
            let attributedText = NSMutableAttributedString(string: newText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.nightRider, range: NSRange(location: 0, length: 10))
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 10, length: newLength - 10))
            textField.attributedText = attributedText
        }
        
        return false
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss keyboard when return key is pressed
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Highlight border when editing begins
        backgroundTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Restore border color when editing ends
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}