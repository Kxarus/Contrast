//
//  PincodeStack.swift
//  contrast
//
//  Created by Александра Орлова on 29.06.2023.
//

import UIKit

final class PincodeStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension PincodeStack {
    private func setupStackView() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.contentMode = .center
        for _ in 1...Constants.pincodeLength {
            let digitView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 17))
            digitView.backgroundColor = .white
            digitView.layer.cornerRadius = digitView.bounds.width / 2
            digitView.layer.borderWidth = 1
            digitView.layer.borderColor = UIColor.black.cgColor
            self.addArrangedSubview(digitView)
            self.setCustomSpacing(12, after: digitView)
        }
    }
}

// MARK: - Public methods
extension PincodeStack {
    func colorPoints(count: Int) {
        for i in 0...(Constants.pincodeLength - 1) {
            let view = self.arrangedSubviews[i]
            view.backgroundColor = i < count ? R.color.accent() : .white
            view.layer.borderColor = i < count ? R.color.accent()?.cgColor : UIColor.black.cgColor
        }
    }
}

