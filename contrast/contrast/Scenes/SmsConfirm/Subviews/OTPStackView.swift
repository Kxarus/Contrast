//
//  OTPTextField.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//

import UIKit

protocol OTPDelegateProtocol: AnyObject {
    func didChangeValidity(isValid: Bool)
    func hideError()
}

final class OTPTextField: UITextField {
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
   }
}


final class OTPStackView: UIStackView {
    private let numberOfFields = 4
    private var textFieldsCollection: [OTPTextField] = []
    private var remainingStrStack: [String] = []
    
    weak var delegate: OTPDelegateProtocol?
    var hasError = false {
        didSet {
            changeAllFieldColor()
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        addOTPFields()
    }
}

//MARK: - Public methods
extension OTPStackView {
    func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        
        return OTP
    }
}

//MARK: - Private methods
extension OTPStackView {
    private func setupStackView() {
        self.backgroundColor = UIColor.mainBackgroundColor
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 12
    }
    
    private func changeAllFieldColor() {
        let newBorderColor = hasError ? UIColor.delColor : UIColor.borderLight
        
        for textField in textFieldsCollection{
            textField.layer.borderColor = newBorderColor.cgColor
            textField.backgroundColor = UIColor.mainBackgroundColor
            textField.text = ""
        }
    }
    
    private func addOTPFields() {
        for index in 0 ..< numberOfFields {
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
           
            if index != 0 {
                field.previousTextField = textFieldsCollection[index - 1]
                textFieldsCollection[index - 1].nextTextField = field
            } else {
                field.previousTextField = nil
            }
        }
        
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    private func setupTextField(_ textField: OTPTextField) {
        self.addArrangedSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = R.color.mainBackgroundColor()
        textField.tintColor = R.color.mainBackgroundColor()
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = GeneralFonts.generalMedium24
        textField.textColor = R.color.textColor()
        textField.layer.cornerRadius = 26
        textField.layer.borderWidth = 1
        textField.layer.borderColor = R.color.borderLight()?.cgColor
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
        
        setupTextFieldConstraints(textField)
    }
    
    private func setupTextFieldConstraints(_ textField: OTPTextField) {
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(52)
            $0.width.equalTo(52)
        }
    }
    
    private func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{ String($0) }
        
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        
        checkForValidity()
        remainingStrStack = []
    }
    
    private func checkForValidity() {
        for fields in textFieldsCollection {
            if (fields.text == "") {
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        
        delegate?.didChangeValidity(isValid: true)
    }
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.hideError()
        textField.layer.borderColor = R.color.borderDark()?.cgColor
        textField.backgroundColor = R.color.mainBackgroundColor()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
        if textField.text?.isEmpty == true {
            textField.layer.borderColor = R.color.borderLight()?.cgColor
            textField.backgroundColor = R.color.mainBackgroundColor()
        } else {
            textField.layer.borderColor = R.color.accent()?.cgColor
            textField.backgroundColor = R.color.accent()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0) {
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                
                return false
            }
            
            return true
        }
    }
}
