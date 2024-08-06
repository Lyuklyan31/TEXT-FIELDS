//
//  CustomeOnlyCharactersTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomeOnlyCharactersTextField: UIView {
    
    private let backgroundView = UIView()
    private let textField = UITextField()
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }
    
    private func setupCustomTextField() {
        // Title Label
        titleLabel.text = "Only characters"
        titleLabel.font = UIFont(name: "Rubik", size: 13)
        titleLabel.textColor = UIColor(named: "nightRider")
        self.addSubview(titleLabel)
        
        // Background View
        backgroundView.backgroundColor = UIColor(named: "fieldGray")
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(named: "fieldGray")?.withAlphaComponent(0.12).cgColor
        self.addSubview(backgroundView)
        
        // Text Field
        textField.placeholder = "wwwww-ddddd"
        textField.font = UIFont(name: "Rubik", size: 17)
        backgroundView.addSubview(textField)
        
        // Setting Constraints
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
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

extension CustomeOnlyCharactersTextField: UITextFieldDelegate {
    enum InputState {
        case letters
        case hyphen
        case digits
    }
    
    func determineInputState(for text: String) -> InputState {
        switch text.count {
        case 0...4:
            return .letters
        case 5:
            return .hyphen
        default:
            return .digits
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Limit total length to 11 characters (5 letters + 1 hyphen + 5 digits)
        if newText.count > 11 {
            return false
        }
        
        // Determine current input state
        let inputState = determineInputState(for: currentText)
        
        switch inputState {
        case .letters:
            if !CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: string)) {
                return false
            }
        case .hyphen:
            if string != "" {
                textField.text = currentText + "-"
                return false
            }
        case .digits:
            if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
                return false
            }
        }
        
        // Handle backspace (deleting)
        if range.length == 1 && string.isEmpty && currentText.count == 6 {
            textField.text = (currentText as NSString).substring(to: 5)
            return false
        }
        
        return true
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
