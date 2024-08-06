//
//  CustomTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomeNoDigitsTextField: UIView {
    
    private let backraund = UIView()
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
        titleLabel.text = "NO digits field"
        titleLabel.font = UIFont(name: "Rubik", size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        backraund.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backraund.snp.top).offset(-4)
        }
        
        textField.placeholder = "Type here"
        textField.font = UIFont(name: "Rubik", size: 17)
        
        backraund.backgroundColor = UIColor.fieldGray
        backraund.layer.cornerRadius = 11
        
        backraund.layer.borderWidth = 1.0
        backraund.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        self.addSubview(backraund)
        
        backraund.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        backraund.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        textField.delegate = self
    }
}

extension CustomeNoDigitsTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
