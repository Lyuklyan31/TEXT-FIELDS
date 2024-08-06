//
//  ViewController.swift
//  TextFields
//
//  Created by admin on 05.08.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // UI Elements
    private let titleLabel = UILabel()
    
    private let noDigitsTextField = CustomTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemBackground
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupNoDigitsTextField()
        setupGestures()
    }
    
    // Setup TitleLabel
    private func setupTitleLabel() {
        titleLabel.text = "Text Fields"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Rubik", size: 34)
        titleLabel.textColor = UIColor(named: "nightRider")
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(92)
            make.leading.trailing.equalTo(view).inset(16)
        }
    }
    
    private func setupNoDigitsTextField() {
        view.addSubview(noDigitsTextField)
        noDigitsTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(54)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(44)
        }
    }
    private func setupDelegates() {
        noDigitsTextField.textField.delegate = self 
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}
