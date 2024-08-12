//
//  ViewController.swift
//  TextFields
//
//  Created by admin on 05.08.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let headerTitleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let showTabBarButton = UIButton()
    
    private let noDigitsTextField = NoDigitsTextField()
    private let limitTextField = LimitTextField(characterLimit: 10)
    private let onlyCharactersTextField = OnlyCharactersTextField()
    private let linkTextField = LinkTextField()
    private let passwordTextField = PasswordTextField()
    
    private var keyboardManager: KeyboardManager?

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDefaults()
    }
    
    // MARK: - Default Configuration
    
    private func configureDefaults() {
        keyboardManager = KeyboardManager(viewController: self, scrollView: scrollView)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupHeaderTitleLabel()
        setupStackView()
        setupGestures()
        setupShowTabBarButton()
    }
    
    // MARK: - Scroll View Setup
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    // MARK: - Header Title Label Setup
    
    private func setupHeaderTitleLabel() {
        contentView.addSubview(headerTitleLabel)
        headerTitleLabel.text = "Text Fields"
        headerTitleLabel.textAlignment = .center
        headerTitleLabel.font = UIFont(name: "Rubik-Medium", size: 34)
        headerTitleLabel.textColor = UIColor.nightRider
        
        headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(48)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
    }
    
    // MARK: - Stack View Setup
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fill
        
        [noDigitsTextField, limitTextField, onlyCharactersTextField, linkTextField, passwordTextField].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { $0.height.equalTo(66) }
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    func setupShowTabBarButton() {
        view.addSubview(showTabBarButton)
        showTabBarButton.setTitle("Show Tab Bar", for: .normal)
        showTabBarButton.layer.cornerRadius = 11
        showTabBarButton.backgroundColor = .systemBlue

        showTabBarButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        showTabBarButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
    }

    // MARK: - Setup Gestures
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func showTabBar() {
        let tabBarVC = TextFieldsTabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}
