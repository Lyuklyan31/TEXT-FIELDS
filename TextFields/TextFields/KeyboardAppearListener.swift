//
//  KeyboardAppearListener.swift
//  TextFields
//
//  Created by admin on 07.08.2024.
//

import UIKit

class KeyboardAppearListener {
    private weak var viewController: UIViewController?

    private var isKeyboardShown: Bool = false

    init(viewController: UIViewController) {
        self.viewController = viewController

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard
            let viewController = viewController,
            let userInfo = notification.userInfo,
            let beginKeyboardFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let endKeyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            endKeyboardFrame != beginKeyboardFrame,
            isKeyboardShown == false
        else {
            return
        }

        let windowSafeArea: CGFloat = viewController.view.safeAreaInsets.bottom - viewController.additionalSafeAreaInsets.bottom

        viewController.additionalSafeAreaInsets.bottom += (beginKeyboardFrame.origin.y - endKeyboardFrame.origin.y - windowSafeArea)

        animateUpdates(userInfo, viewController)
        isKeyboardShown = true
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard
            let viewController = viewController,
            let userInfo = notification.userInfo,
            let beginKeyboardFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let endKeyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            isKeyboardShown == true
        else {
            return
        }

        let windowSafeArea: CGFloat = viewController.view.safeAreaInsets.bottom - viewController.additionalSafeAreaInsets.bottom

        viewController.additionalSafeAreaInsets.bottom -= (endKeyboardFrame.origin.y - beginKeyboardFrame.origin.y - windowSafeArea)

        animateUpdates(userInfo, viewController)
        isKeyboardShown = false
    }

    private func animateUpdates(_ userInfo: [AnyHashable: Any], _ viewController: UIViewController) {
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
            .flatMap { $0 as? Double } ?? 0.25

        if duration > 0 {
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]
                .flatMap { $0 as? Int }
                .flatMap { UIView.AnimationCurve(rawValue: $0) } ?? .easeInOut

            UIViewPropertyAnimator(duration: duration, curve: curve) {
                viewController.view.layoutIfNeeded()
            }
            .startAnimation()
        } else {
            viewController.view.layoutIfNeeded()
        }
    }
}
