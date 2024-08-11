//
//  KeyboardAppearListener.swift
//  TextFields
//
//  Created by admin on 07.08.2024.
//

import UIKit

class KeyboardManager {

private weak var viewController: MainViewController?
private weak var scrollView: UIScrollView?

init(viewController: MainViewController, scrollView: UIScrollView) {
    self.viewController = viewController
    self.scrollView = scrollView
    registerForKeyboardNotifications()
}

private func registerForKeyboardNotifications() {
    
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillShow(_:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil
    )
    
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(keyboardWillHide(_:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil
    )
}

@objc private func keyboardWillShow(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
    
    let keyboardHeight = keyboardFrame.height
    let bottomInset = keyboardHeight - (viewController?.view.safeAreaInsets.bottom ?? 0)
    
    let adaptiveInset = bottomInset * 0.3
    let finalInset = bottomInset + adaptiveInset
    
    scrollView?.contentInset.bottom = finalInset
    scrollView?.verticalScrollIndicatorInsets.bottom = finalInset
    
    UIView.animate(withDuration: 0.3) {
        self.viewController?.view.layoutIfNeeded()
    }
}

@objc private func keyboardWillHide(_ notification: Notification) {
    scrollView?.contentInset.bottom = 0
    scrollView?.verticalScrollIndicatorInsets.bottom = 0
    
    UIView.animate(withDuration: 0.3) {
        self.viewController?.view.layoutIfNeeded()
    }
}
}
