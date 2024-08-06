import UIKit
import SnapKit

class CustomeNoDigitsTextField: UIView {
    
    private let background = UIView()
    private let textField = UITextField()
    private let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupCustomTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTextField()
    }
    
    private func setupCustomTextField() {
        titleLabel.text = "NO digits field"
        titleLabel.font = UIFont(name: "RubikRegular", size: 13)
        titleLabel.textColor = UIColor.nightRider
        
        background.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(background.snp.top).offset(-4)
            make.leading.equalToSuperview()
        }
        
        textField.placeholder = "Type here"
        textField.font = UIFont(name: "RubikRegular", size: 17)
        
        background.backgroundColor = UIColor.fieldGray
        background.layer.cornerRadius = 11
        
        background.layer.borderWidth = 1.0
        background.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
        
        self.addSubview(background)
        
        background.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview()
        }
        
        background.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8))
        }
        
        textField.delegate = self
    }
}

extension CustomeNoDigitsTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789")
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        background.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        background.layer.borderColor = UIColor(.fieldGray.opacity(0.12)).cgColor
    }
}
