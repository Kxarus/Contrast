//
//  MainButton.swift
//  contrast
//
//  Created by Roman Kiruxin on 29.06.2023.
//

import UIKit

enum MainButtonStyle {
    case border(image: UIImage? = nil)
    case fill
    case emptyFill
    case borderWhite
}

final class MainButton: UIButton {

    // MARK: - Internal vars
    private(set) var activeBackgroundColor = UIColor.mainButtonColor
    private(set) var activeBorderColor = UIColor.clear.cgColor
    private(set) var activeTextColor = UIColor.white
    private(set) var inactiveBackgroundColor = UIColor.mainButtonInactiveColor
    private(set) var inactiveBorderColor = UIColor.clear.cgColor
    private(set) var inactiveTextColor = UIColor.white
    private(set) var textFont = GeneralFonts.generalRegular15
    private(set) var radius: CGFloat = 17
    private(set) var borderWidth: CGFloat = 0
   
    var isEnabledButton: Bool = true {
        didSet {
            isEnabledButton ? setupActiveButton() : setupInactiveButton()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
}

// MARK: - Private methods
extension MainButton {
    private func setupButton() {
        titleLabel?.font = textFont
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        setupActiveButton()
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupInactiveButton() {
        setTitleColor(inactiveTextColor, for: .normal)
        backgroundColor = inactiveBackgroundColor
        layer.borderColor = inactiveBorderColor
        isEnabled = false
    }
    
    private func setupActiveButton() {
        backgroundColor = activeBackgroundColor
        setTitleColor(activeTextColor, for: .normal)
        layer.borderColor = activeBorderColor
        isEnabled = true
    }
}

// MARK: - Private public
extension MainButton {
    func setupStyle(style: MainButtonStyle = .fill) {
        switch style {
        case .border(let image):
            backgroundColor = UIColor.secondaryButtonColor
            layer.borderColor = UIColor.borderLight.cgColor
            setTitleColor(.textDark2, for: .normal)
            layer.borderWidth = 1
            if image != nil {
                setImage(image, for: .normal)
                var configuration = UIButton.Configuration.plain()
                configuration.imagePadding = 10
                self.configuration = configuration
            }
        case .emptyFill:
            backgroundColor = .clear
            layer.borderColor = UIColor.clear.cgColor
            setTitleColor(.textDark2, for: .normal)
            layer.borderWidth = 0
        case .borderWhite:
            backgroundColor = .clear
            setTitleColor(.white, for: .normal)
            layer.borderColor = UIColor.white.cgColor
            layer.borderWidth = 1
        default:
            break
        }
    }
}
