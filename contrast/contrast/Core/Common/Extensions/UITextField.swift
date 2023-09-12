//
//  UITextField.swift
//  contrast
//
//  Created by Roman Kiruxin on 03.07.2023.
//

import UIKit

extension UITextField {
    
    //MARK: - Phone Mask Default
    func addPhoneMaskDefault(in range: NSRange, replacementString string: String) {
        guard let text = self.text else {
            return
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        self.text = MaskWorker.format(with: "(XXX) XXX-XX-XX", phone: newString)
        if self.text?.count == 18 {
            self.resignFirstResponder()
        }
        return
    }
    
    func addCardNumberMask(in range: NSRange, replacementString string: String) {
        guard let text = self.text else {
            return
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        self.text = MaskWorker.format(with: "XXXX XXXX XXXX XXXX", phone: newString)
        if self.text?.count == 19 {
            self.resignFirstResponder()
        }
        return
    }
    
    func addValidityPeriodMask(in range: NSRange, replacementString string: String) {
        guard let text = self.text else {
            return
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        self.text = MaskWorker.format(with: "XX/XX", phone: newString)
        if self.text?.count == 5 {
            self.resignFirstResponder()
        }
        return
    }
    
    func addCVCMask(in range: NSRange, replacementString string: String) {
        guard let text = self.text else {
            return
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        self.text = MaskWorker.format(with: "XXX", phone: newString)
        if self.text?.count == 3 {
            self.resignFirstResponder()
        }
        return
    }
}
