//
//  CustomMaxSize10TextField.swift
//  TextFields
//
//  Created by admin on 06.08.2024.
//

import UIKit
import SnapKit

class LimitView: UIView {
    
    // MARK: - UI Elements
    
    private let titleLabel = UILabel()
    var characterCountLabel = UILabel()
    let backgroundView = UIView()
    let textField = UITextField()
    
    private var characterLimit: Int
    
    // MARK: - Initializers
    
    init(_ characterLimit: Int) {
        self.characterLimit = characterLimit
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.characterLimit = 0
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI and Constraints
    
    // Configures the UI elements and their layout.
    private func setupUI() {
        // Setup title label
        titleLabel.text = "Input limit"
        titleLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        // Setup background view
        backgroundView.backgroundColor = UIColor.fieldGray
        backgroundView.layer.cornerRadius = 11
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        // Setup character count label
        characterCountLabel.text = "\(characterLimit)"
        characterCountLabel.font = UIFont.setFont(.rubikRegular, size: 13)
        characterCountLabel.textColor = UIColor.nightRider
        
        addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(backgroundView.snp.top).offset(-7)
            $0.trailing.equalToSuperview()
        }

        // Setup text field
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.ownPlaceholder]
        )
        textField.font = UIFont.setFont(.rubikRegular, size: 17)
        textField.delegate = self
        textField.accessibilityIdentifier = "limitTextField"
        
        backgroundView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(7)
        }
    }
    // MARK: - Testable Access for Unit Tests
    #if DEBUG
    var testableTextField: UITextField {
        return textField
    }
    #endif
}

// MARK: - UITextFieldDelegate

extension LimitView: UITextFieldDelegate {
    
    // Handles character input and updates character count and text field appearance.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        let newLength = newText.count
        
        let remainingCharacters = characterLimit - newLength
        
        updateCharacterCountLabel(remainingCharacters: remainingCharacters)
        updateTextFieldAppearance(newText: newText, newLength: newLength)
        
        return false
    }

    // Updates the label showing remaining characters.
    private func updateCharacterCountLabel(remainingCharacters: Int) {
        if remainingCharacters >= 0 {
            characterCountLabel.text = "\(remainingCharacters)"
            characterCountLabel.textColor = UIColor.nightRider
        } else {
            characterCountLabel.text = "-\(-remainingCharacters)"
            characterCountLabel.textColor = .red
        }
    }

    // Changes text field appearance based on character count.
    private func updateTextFieldAppearance(newText: String, newLength: Int) {
        let attributedText = NSMutableAttributedString(string: newText)
        
        if newLength <= characterLimit {
            attributedText.addAttribute(.foregroundColor, value: UIColor.nightRider, range: NSRange(location: 0, length: newLength))
            backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            attributedText.addAttribute(.foregroundColor, value: UIColor.nightRider, range: NSRange(location: 0, length: characterLimit))
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: characterLimit, length: newLength - characterLimit))
            backgroundView.layer.borderColor = UIColor.red.cgColor
        }
        
        textField.attributedText = attributedText
    }
    
    // Dismisses the keyboard when the return key is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Changes the border color when editing begins.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // Resets the border color when editing ends based on text length.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > characterLimit {
            backgroundView.layer.borderColor = UIColor.red.cgColor
        } else {
            backgroundView.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        }
    }
}
