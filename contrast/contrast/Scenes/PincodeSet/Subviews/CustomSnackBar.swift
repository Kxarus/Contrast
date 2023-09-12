//
//  CustomSnackBar.swift
//  contrast
//
//  Created by Александра Орлова on 30.06.2023.
//

import UIKit

enum SnackBarType {
    case wrongPincode
    case copy
}

final class CustomSnackbar: UIView {
    
    private let animationDuration = 0.2
    private let displayDuration = 3.0
    private let snackbarHeight = 40.0
    private var snackbarWidth = 0.0
    private var messageLabel = UILabel()
    private var type: SnackBarType
    
    init(type: SnackBarType) {
        self.type = type
        
        switch type {
        case .copy:
            snackbarWidth = 120.0
        case .wrongPincode:
            snackbarWidth = 260.0
        }
        
        let screenSize = UIScreen.main.bounds.size
        let snackbarFrame = CGRect(x: (screenSize.width - snackbarWidth) / 2, y: screenSize.height - snackbarHeight, width: snackbarWidth, height: snackbarHeight)
        super.init(frame: snackbarFrame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension CustomSnackbar {
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = R.color.textDark2()?.cgColor
        backgroundColor = R.color.secondaryButtonColor()
        layer.cornerRadius = snackbarHeight / 2.0
        
        messageLabel = UILabel(frame: bounds)
        messageLabel.textColor = R.color.textDark2()
        messageLabel.textAlignment = .center
        messageLabel.font = GeneralFonts.generalRegular15
        addSubview(messageLabel)
        
        switch type {
        case .copy:
            messageLabel.text = R.string.localizable.copied()
        case .wrongPincode:
            messageLabel.text = R.string.localizable.wrongPincode()
        }
    }
    
    private func hideSnackbar() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame.origin.y += self.frame.height
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}

// MARK: - Public methods
extension CustomSnackbar {
    func showSnackbar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene, let keyWindow = windowScene.windows.first else {
            return
        }
        
        keyWindow.addSubview(self)
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame.origin.y -= self.frame.height
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + self.displayDuration, execute: {
                self.hideSnackbar()
            })
        })
    }
}
