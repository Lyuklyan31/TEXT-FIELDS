//
//  TabBarViewController.swift
//  TextFields
//
//  Created by admin on 13.08.2024.
//

import UIKit
import SnapKit

enum ScreenState: Equatable {
    case noDigits
    case limit
    case onlyCharacters
    case link
    case password
}

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
    
    private var currentState: ScreenState = .noDigits {
        didSet {
            updateViewForCurrentState()
            updateButtonSelection()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupTabBarContainer()
        setupButtons()
        updateViewForCurrentState()
        updateButtonSelection()
    }
    
    private func setupTabBarContainer() {
        view.addSubview(tabBarContainer)
        tabBarContainer.backgroundColor = .systemBackground
        
        tabBarContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
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
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(10)
        }
        
        stackView.addArrangedSubview(noDigitsButton)
        stackView.addArrangedSubview(limitButton)
        stackView.addArrangedSubview(onlyCharactersButton)
        stackView.addArrangedSubview(linkButton)
        stackView.addArrangedSubview(passwordButton)
    }
    
    private func setupButtons() {
        setupButton(noDigitsButton, title: "No Digits", imageName: "1.circle", type: .noDigits)
        setupButton(limitButton, title: "Limit", imageName: "2.circle", type: .limit)
        setupButton(onlyCharactersButton, title: "Characters", imageName: "3.circle", type: .onlyCharacters)
        setupButton(linkButton, title: "Link", imageName: "4.circle", type: .link)
        setupButton(passwordButton, title: "Password", imageName: "5.circle", type: .password)
    }
    
    private func setupButton(_ button: UIButton, title: String, imageName: String, type: ScreenState) {
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
        switch sender {
        case noDigitsButton:
            currentState = .noDigits
        case limitButton:
            currentState = .limit
        case onlyCharactersButton:
            currentState = .onlyCharacters
        case linkButton:
            currentState = .link
        case passwordButton:
            currentState = .password
        default:
            return
        }
    }
    
    // MARK: - Update View
    
    private func updateViewForCurrentState() {
        // Remove current child view controller if any
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        // Determine which view controller to add
        let newViewController: UIViewController
        switch currentState {
        case .noDigits:
            newViewController = ViewControllerType.noDigits.viewController
        case .limit:
            newViewController = ViewControllerType.limit.viewController
        case .onlyCharacters:
            newViewController = ViewControllerType.onlyCharacters.viewController
        case .link:
            newViewController = ViewControllerType.link.viewController
        case .password:
            newViewController = ViewControllerType.password.viewController
        }

        // Add the new view controller as a child
        addChild(newViewController)
        view.insertSubview(newViewController.view, belowSubview: tabBarContainer)
        newViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarDividerLine.snp.top)
        }
        newViewController.didMove(toParent: self)
    }
    
    // MARK: - Update Button Selection
    
    private func updateButtonSelection() {
        let selectedButton: UIButton
        
        switch currentState {
        case .noDigits:
            selectedButton = noDigitsButton
        case .limit:
            selectedButton = limitButton
        case .onlyCharacters:
            selectedButton = onlyCharactersButton
        case .link:
            selectedButton = linkButton
        case .password:
            selectedButton = passwordButton
        }
        
        
        let allButtons = [noDigitsButton, limitButton, onlyCharactersButton, linkButton, passwordButton]
        allButtons.forEach { button in
            button.tintColor = .label
        }
        
        selectedButton.tintColor = .systemBlue
    }
}
