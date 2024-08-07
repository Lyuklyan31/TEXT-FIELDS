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
    private let titleLabel = UILabel()
    
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomTextField() {
        
        titleLabel.text = "Validation rules"
        titleLabel.font = UIFont(name: "RubikRegular", size: 13)
        titleLabel.textColor = UIColor.nightRider
        self.addSubview(titleLabel)
        
        // Background View
        backgroundTextField.backgroundColor = UIColor.fieldGray
        backgroundTextField.layer.cornerRadius = 11
        backgroundTextField.layer.borderWidth = 1.0
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        self.addSubview(backgroundTextField)
        
        // Text Field
        textField.placeholder = "Password"
        textField.font = UIFont(name: "RubikRegular", size: 17)
        
        backgroundTextField.addSubview(textField)
        
        // Setting Constraints
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        backgroundTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
    }
    
}
    
