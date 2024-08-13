//
//  UIFontExtension.swift
//  TextFields
//
//  Created by admin on 08.08.2024.
//

import UIKit

extension UIFont {

    // MARK: - Font Types

    public enum FontType: String {
        case regular = ""
        case rubikMedium = "Rubik-Medium"
        case rubikLight = "Rubik-Light"
        case rubikRegular = "Rubik-Regular"
    }

    // MARK: - Font Creation

    static func setFont(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
