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
        
    }
    private func setupUI(){
        
    }

    private func setupTitleLabel() {
        titleLabel.text = "Text Fields"
        titleLabel.font = UIFont(name: "Rubik-Black", size: 34)
        
        view.addSubview(titleLabel)
     
        
    }
}

