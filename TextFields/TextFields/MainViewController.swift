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
    
    private let noDigitsTextField = CustomeNoDigitsTextField()
    private let maxSize10TextField = CustomMaxSize10TextField()
    private let onlyCharactersTextField = CustomeOnlyCharactersTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemBackground
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupNoDigitsTextField()
        setupMaxSize10TextField()
        setupOnlyCharactersTextField()
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(48)
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
    
    private func setupMaxSize10TextField() {
        view.addSubview(maxSize10TextField)
        maxSize10TextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noDigitsTextField.snp.bottom).offset(54)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(44)
        }
    }
    
    private func setupOnlyCharactersTextField() {
        view.addSubview(onlyCharactersTextField)
        onlyCharactersTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(maxSize10TextField.snp.bottom).offset(54)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(44)
        }
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

