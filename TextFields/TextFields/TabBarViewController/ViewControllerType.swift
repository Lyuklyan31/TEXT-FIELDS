//
//  ViewControllerType.swift
//  TextFields
//
//  Created by admin on 14.08.2024.
//

import UIKit

// MARK: - ViewControllerType Enum

enum ViewControllerType {
    
    case noDigits
    case limit
    case onlyCharacters
    case link
    case password
    
    // MARK: - Computed Property
    
    var viewController: UIViewController {
        switch self {
        case .noDigits:
            return NoDigitsViewController()
        case .limit:
            return LimitViewController()
        case .onlyCharacters:
            return OnlyCharactersViewController()
        case .link:
            return LinkViewController()
        case .password:
            return PasswordViewController()
        }
    }
}
