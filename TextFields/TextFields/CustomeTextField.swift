//
//  CustomTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomTextField: UIView {
    private var placeholderText: String
    private var titleText: String
    
    private let backraund = UIView()
    let textField = UITextField()
    private let titleLabel = UILabel()
    
    init(placeholderText: String, titleText: String) {
        self.placeholderText = placeholderText
        self.titleText = titleText
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomTextField() {
        titleLabel.text = titleText
        titleLabel.font = UIFont(name: "Rubik", size: 13)
        titleLabel.textColor = UIColor(named: "nightRider")
        
        backraund.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backraund.snp.top).offset(-4)
        }
        
        textField.placeholder = placeholderText
        textField.font = UIFont(name: "Rubik", size: 17)
        
        backraund.backgroundColor = UIColor(named: "fieldGray")
        backraund.layer.cornerRadius = 11
        
        backraund.layer.borderWidth = 1.0
        backraund.layer.borderColor = UIColor(named: "fieldGray")?.withAlphaComponent(0.12).cgColor
        
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

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}
