//
//  UIFontExtension.swift
//  TextFields
//
//  Created by admin on 08.08.2024.
//

import UIKit

extension UIFont {
    
    public enum fontType: String {
        case regular = ""
        case rubikMedium = "Rubik-Medium"
        case rubikLight = "Rubik-Light"
        case rubikRegular = "Rubik-Regular"
    }
    
    static func setFont(_ type: fontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
