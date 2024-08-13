//
//  TextFieldsTabBarController.swift
//  TextFields
//
//  Created by admin on 12.08.2024.
//

import UIKit
import SnapKit

class TextFieldsTabBarController: UITabBarController {
    
    // MARK: - Text Field Properties
    // Initialization of text fields that will be used in different tabs.
    private let noDigitsTextField = NoDigitsTextField()
    private let limitTextField = LimitTextField(10)
    private let onlyCharactersTextField = OnlyCharactersTextField()
    private let linkTextField = LinkTextField()
    private let passwordTextField = PasswordTextField()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    // Configures the tab bar and adds view controllers with their respective text fields.
    private func setupTabBar() {
        
        setupGestures()
        
        // Setup No Digits TextField tab
        let noDigitsVC = UIViewController()
        noDigitsVC.view.backgroundColor = .systemBackground
        noDigitsVC.tabBarItem = UITabBarItem(title: "No Digits", image: UIImage(systemName: "1.circle"), tag: 0)
        noDigitsVC.view.addSubview(noDigitsTextField)
        setupButton(in: noDigitsVC)
        
        noDigitsTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }
        
        // Setup Limit TextField tab
        let limitVC = UIViewController()
        limitVC.view.backgroundColor = .systemBackground
        limitVC.tabBarItem = UITabBarItem(title: "Limit", image: UIImage(systemName: "2.circle"), tag: 1)
        limitVC.view.addSubview(limitTextField)
        setupButton(in: limitVC)
        
        limitTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }

        // Setup Only Characters TextField tab
        let onlyCharactersVC = UIViewController()
        onlyCharactersVC.view.backgroundColor = .systemBackground
        onlyCharactersVC.tabBarItem = UITabBarItem(title: "Only Characters", image: UIImage(systemName: "3.circle"), tag: 2)
        onlyCharactersVC.view.addSubview(onlyCharactersTextField)
        setupButton(in: onlyCharactersVC)
       
        onlyCharactersTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }

        // Setup Link TextField tab
        let linkVC = UIViewController()
        linkVC.view.backgroundColor = .systemBackground
        linkVC.tabBarItem = UITabBarItem(title: "Link", image: UIImage(systemName: "4.circle"), tag: 3)
        linkVC.view.addSubview(linkTextField)
        setupButton(in: linkVC)
        
        linkTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }

        // Setup Password TextField tab
        let passwordVC = UIViewController()
        passwordVC.view.backgroundColor = .systemBackground
        passwordVC.tabBarItem = UITabBarItem(title: "Password", image: UIImage(systemName: "5.circle"), tag: 4)
        passwordVC.view.addSubview(passwordTextField)
        setupButton(in: passwordVC)
      
        passwordTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(66)
        }

        // Assign the view controllers to the tab bar.
        viewControllers = [noDigitsVC, limitVC, onlyCharactersVC, linkVC, passwordVC]
    }
    
    // Configures the "Back" button in each view controller.
    private func setupButton(in viewController: UIViewController) {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.layer.cornerRadius = 11
        button.backgroundColor = .systemBlue
        viewController.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(viewController.view.safeAreaLayoutGuide.snp.bottom).offset(-25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        // Adds an action to the button to dismiss the tab bar when pressed.
        button.addTarget(self, action: #selector(dismissTabBar), for: .touchUpInside)
    }
    
    // Adds a gesture recognizer to dismiss the keyboard when tapping outside of a text field.
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // Dismisses the tab bar controller.
    @objc private func dismissTabBar() {
        dismiss(animated: true, completion: nil)
    }

    // Dismisses the keyboard when tapping outside of the text field.
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
