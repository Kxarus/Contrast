//
//  Padding.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 07.07.2023.
//

import Foundation
import UIKit

final class RightPaddingTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
