//
//  TabBarViewController.swift
//  TextFields
//
//  Created by admin on 13.08.2024.
//

import UIKit
import SnapKit

class TabBarViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let noDigitsButton = UIButton()
    private let limitButton = UIButton()
    private let onlyCharactersButton = UIButton()
    private let linkButton = UIButton()
    private let passwordButton = UIButton()
    
    private let noDigitsViewController = NoDigitsViewController()
    private let limitViewController = LimitViewController()
    private let onlyCharactersViewController = OnlyCharactersViewController()
    private let linkViewController = LinkViewController()
    private let passwordViewController = PasswordViewController()
    
    private let stackView = UIStackView()
    private let tabBarContainer = UIView()
    private let tabBarDividerLine = UIView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewControllers()
        showViewController(noDigitsViewController)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupTabBarContainer()
        setupButtons()
    }
    
    func showViewController(_ viewController: UIViewController) {
        for child in children {
            child.view.isHidden = true
        }
        updateTabBarButtons(for: viewController)
        
        viewController.view.isHidden = false
        view.bringSubviewToFront(viewController.view)
    }
    
    private func setupViewControllers() {
        let containerView = UIView()
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarContainer.snp.top)
        }
        
        let viewControllers: [UIViewController] = [
                noDigitsViewController,
                limitViewController,
                onlyCharactersViewController,
                linkViewController,
                passwordViewController
            ]
        
        for viewController in viewControllers {
            addChild(viewController)
            containerView.addSubview(viewController.view)
            viewController.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            viewController.didMove(toParent: self)
        }
    }
    
    
    private func setupTabBarContainer() {
        view.addSubview(tabBarContainer)
        tabBarContainer.backgroundColor = .systemBackground
        
        tabBarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).inset(15)
        }
        
        view.addSubview(tabBarDividerLine)
        tabBarDividerLine.backgroundColor = .black
        
        tabBarDividerLine.snp.makeConstraints { make in
            make.top.equalTo(tabBarContainer.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
      
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        tabBarContainer.addSubview(stackView)
       
        stackView.snp.makeConstraints { make in
            make.top.equalTo(tabBarDividerLine.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalTo(tabBarContainer.snp.bottom).inset(10)
        }
        
        stackView.addArrangedSubview(noDigitsButton)
        stackView.addArrangedSubview(limitButton)
        stackView.addArrangedSubview(onlyCharactersButton)
        stackView.addArrangedSubview(linkButton)
        stackView.addArrangedSubview(passwordButton)
    }

    
    private func setupButtons() {
        setupButton(noDigitsButton, title: "No Digits", imageName: "1.circle")
        setupButton(limitButton, title: "Limit", imageName: "2.circle")
        setupButton(onlyCharactersButton, title: "Characters", imageName: "3.circle")
        setupButton(linkButton, title: "Link", imageName: "4.circle")
        setupButton(passwordButton, title: "Password", imageName: "5.circle")
        
        noDigitsButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        limitButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        onlyCharactersButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        linkButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        passwordButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    private func setupButton(_ button: UIButton, title: String, imageName: String) {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = UIImage(systemName: imageName)
        config.imagePlacement = .top
        config.imagePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        config.titleLineBreakMode = .byTruncatingTail
        
        button.configuration = config
        button.configurationUpdateHandler = { button in
            button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 13)
                return outgoing
            }
        }
        button.tintColor = .label
    }
    
    @objc private func handleButtonTap(_ sender: UIButton) {
        switch sender {
        case noDigitsButton:
            showViewController(noDigitsViewController)
        case limitButton:
            showViewController(limitViewController)
        case onlyCharactersButton:
            showViewController(onlyCharactersViewController)
        case linkButton:
            showViewController(linkViewController)
        case passwordButton:
            showViewController(passwordViewController)
        default:
            break
        }
    }
    
    private func updateTabBarButtons(for selectedController: UIViewController) {
        let buttons = [noDigitsButton, limitButton, onlyCharactersButton, linkButton, passwordButton]
        let viewControllers = [noDigitsViewController, limitViewController, onlyCharactersViewController, linkViewController, passwordViewController]
        
        for (index, button) in buttons.enumerated() {
            if viewControllers[index] == selectedController {
                button.tintColor = .systemBlue
            } else {
                button.tintColor = .label
            }
        }
    }
}
