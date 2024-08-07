//
//  CustomePasswordTextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class CustomNoDigitsTextField: UIView {

    private let textField = UITextField()
    private let background = UIView()

    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }

    private func setupCustomTextField() {
        textField.placeholder = "Type here"
        textField.font = UIFont(name: "RubikRegular", size: 17)

        background.backgroundColor = UIColor.fieldGray
        background.layer.cornerRadius = 11
        background.layer.borderWidth = 1.0
        background.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor

        self.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(36)
        }

        background.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }

        textField.delegate = self
    }

    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }

    func setBorderColor(_ color: UIColor) {
        background.layer.borderColor = color.cgColor
    }
}

extension CustomNoDigitsTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        setBorderColor(.blue)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setBorderColor(UIColor(.fieldGray.opacity(0.12)))
    }
}
