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
    
    private let titleLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private let noDigitsTextField = CustomNoDigitsTextField()
    private let limitTextField = LimitTextField(limit: 10)
    private let onlyCharactersTextField = CustomeOnlyCharactersTextField()
    private let linkTextField = CustomLinkTextField()
    private let passwordTextField = CustomePasswordTextField()
    
    private var keyboardHandler: KeyboardAppearListener?

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardHandler = KeyboardAppearListener(viewController: self)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupTitleLabel()
        setupStackView()
        setupGestures()
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
    
    // MARK: - Title Label Setup
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "Text Fields"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.setFont(.rubikMedium, size: 34)
        titleLabel.textColor = UIColor.nightRider
        
        titleLabel.snp.makeConstraints { make in
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }


    
    // MARK: - Keyboard Notifications
    
//    private func registerForKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        
//        let keyboardHeight = keyboardFrame.height
//        let bottomInset = keyboardHeight - view.safeAreaInsets.bottom
//
//        scrollView.contentInset.bottom = bottomInset
//        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
//        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        scrollView.contentInset.bottom = 0
//        scrollView.verticalScrollIndicatorInsets.bottom = 0
//        
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
//    }

    // MARK: - Gestures
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

