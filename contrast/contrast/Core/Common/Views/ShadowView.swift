//
//  ShadowView.swift
//  contrast
//
//  Created by Roman Kiruxin on 04.07.2023.
//

import UIKit

final class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension ShadowView {
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}

//MARK: - Public methods
extension ShadowView {
    func setupView(borderColor: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
    }
}
