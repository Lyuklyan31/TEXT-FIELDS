//
//  ViewController.swift
//  TextFields
//
//  Created by admin on 05.08.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //UI Elements
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    private func setupUI(){
        setupTitleLabel()
        view.backgroundColor = .systemBackground
    }

    private func setupTitleLabel() {
        titleLabel.text = "Text Fields"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Rubik", size: 34)
        titleLabel.textColor = UIColor(.nightRider)
        
        view.addSubview(titleLabel)
     
        titleLabel.snp.makeConstraints { make in
                   make.centerX.equalToSuperview()
                   make.top.equalTo(view.safeAreaLayoutGuide).offset(92)
                   make.leading.trailing.equalTo(view).inset(16)
               }

        
    }
}

