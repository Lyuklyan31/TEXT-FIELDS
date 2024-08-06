import UIKit
import SnapKit

class CustomMaxSize10TextField: UIView {
    
    private let backgroundTextField = UIView()
    private let textField = UITextField()
    private let titleLabel = UILabel()
    private let maxSymbolsLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }
    
    private func setupCustomTextField() {
        // Title Label
        titleLabel.text = "Input limit"
        titleLabel.font = UIFont(name: "RubikRegular", size: 13)
        titleLabel.textColor = UIColor.nightRider
        self.addSubview(titleLabel)
        
        // Max Symbols Label
        maxSymbolsLabel.text = "(0/10)"
        maxSymbolsLabel.font = UIFont(name: "RubikRegular", size: 13)
        maxSymbolsLabel.textColor = UIColor.nightRider
        self.addSubview(maxSymbolsLabel)
        
        // Background View
        backgroundTextField.backgroundColor = UIColor.fieldGray
        backgroundTextField.layer.cornerRadius = 11
        backgroundTextField.layer.borderWidth = 1.0
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        self.addSubview(backgroundTextField)
        
        // Text Field
        textField.placeholder = "Type here"
        textField.font = UIFont(name: "RubikRegular", size: 17)
        backgroundTextField.addSubview(textField)
        
        // Setting Constraints
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        maxSymbolsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundTextField.snp.top).offset(-4)
            make.trailing.equalToSuperview()
        }
        
        backgroundTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        textField.delegate = self
    }
}

extension CustomMaxSize10TextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        let newLength = newText.count
        
        if newLength > 10 {
            maxSymbolsLabel.text = "(-\(newLength - 10))"
            maxSymbolsLabel.textColor = .red
            backgroundTextField.layer.borderColor = UIColor.red.cgColor
            
            let attributedText = NSMutableAttributedString(string: newText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 10, length: newLength - 10))
            textField.attributedText = attributedText
        } else {
            maxSymbolsLabel.text = "(\(newLength)/10)"
            maxSymbolsLabel.textColor = UIColor.nightRider
            backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
            
            let attributedText = NSMutableAttributedString(string: newText)
            attributedText.addAttribute(.foregroundColor, value: UIColor.nightRider, range: NSRange(location: 0, length: newLength))
            textField.attributedText = attributedText
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundTextField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundTextField.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
