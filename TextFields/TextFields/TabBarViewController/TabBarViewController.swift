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
    
    private let stackView = UIStackView()
    private let tabBarContainer = UIView()
    private let tabBarDividerLine = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    // SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupTabBarContainer()
        setupButtons()
    }
    
    // SetupTabBarContainer
    private func setupTabBarContainer() {
        view.addSubview(tabBarContainer)
        tabBarContainer.backgroundColor = .systemBackground
        
        tabBarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
        
        view.addSubview(tabBarDividerLine)
        tabBarDividerLine.backgroundColor = .label
        
        tabBarDividerLine.snp.makeConstraints { make in
            make.bottom.equalTo(tabBarContainer.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        tabBarContainer.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        stackView.addArrangedSubview(noDigitsButton)
        stackView.addArrangedSubview(limitButton)
        stackView.addArrangedSubview(onlyCharactersButton)
        stackView.addArrangedSubview(linkButton)
        stackView.addArrangedSubview(passwordButton)
    }

    
    // SetupButtons
    private func setupButtons() {
        setupButton(noDigitsButton, title: "No Digits", imageName: "1.circle", type: .noDigits)
        setupButton(limitButton, title: "Limit", imageName: "2.circle", type: .limit)
        setupButton(onlyCharactersButton, title: "Characters", imageName: "3.circle", type: .onlyCharacters)
        setupButton(linkButton, title: "Link", imageName: "4.circle", type: .link)
        setupButton(passwordButton, title: "Password", imageName: "5.circle", type: .password)
    }
    
    private func setupButton(_ button: UIButton, title: String, imageName: String, type: ViewControllerType) {
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
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let type: ViewControllerType
        switch sender {
        case noDigitsButton:
            type = .noDigits
        case limitButton:
            type = .limit
        case onlyCharactersButton:
            type = .onlyCharacters
        case linkButton:
            type = .link
        case passwordButton:
            type = .password
        default:
            return
        }
        navigateToViewController(type: type)
    }
    
    private func navigateToViewController(type: ViewControllerType) {
        let viewController = type.viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
