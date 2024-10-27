//
//  NoDigitsViewController.swift
//  TextFields
//
//  Created by admin on 13.08.2024.
//

import UIKit

class NoDigitsViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let noDigitsTextField = NoDigitsView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNoDigitsTextField()
        setupGestures()
    }
    
    private func setupNoDigitsTextField() {
        view.addSubview(noDigitsTextField)
        
        noDigitsTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
            make.top.greaterThanOrEqualToSuperview().offset(16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }

    }
}
