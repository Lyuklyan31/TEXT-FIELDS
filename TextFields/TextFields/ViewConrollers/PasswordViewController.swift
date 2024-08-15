//
//  PasswordViewController.swift
//  TextFields
//
//  Created by admin on 13.08.2024.
//

import UIKit

class PasswordViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let passwordView = PasswordView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupPasswordView()
        setupGestures()
    }
    
    private func setupPasswordView() {
        view.addSubview(passwordView)
        
        passwordView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
            make.top.greaterThanOrEqualToSuperview().offset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
}
