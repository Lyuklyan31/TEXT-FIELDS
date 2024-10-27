//
//  TapToDismissKeyboardExtension.swift
//  TextFields
//
//  Created by admin on 14.08.2024.
//

import UIKit

extension UIViewController {

    // MARK: - Setup Gestures

    // Sets up a tap gesture recognizer to dismiss the keyboard when tapping outside of text fields.
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Keyboard Dismissal

    // Dismisses the keyboard when the tap gesture is recognized.
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
