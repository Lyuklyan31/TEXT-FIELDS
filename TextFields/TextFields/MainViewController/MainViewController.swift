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
    private let button = UIButton()
    
    private let noDigitsView = NoDigitsView()
    private let limitView = LimitView(10)
    private let onlyCharactersView = OnlyCharactersView()
    private let linkView = LinkView()
    private let passwordView = PasswordView()
    
    private let tabBarViewController = TabBarViewController()
    
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
        addTabBar()
    }
    
    private func addTabBar() {
        let tabBarVC = TabBarViewController()
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
        
        tabBarVC.view.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view)
            make.height.equalTo(80)
        }
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
        
        [noDigitsView, limitView, onlyCharactersView, linkView, passwordView].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { $0.height.equalTo(66) }
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(headerTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }

    // MARK: - Setup Gestures
 
    @objc private func showTabBar() {
        let tabBarVC = TabBarViewController()
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
