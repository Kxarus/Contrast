//
//  SupportView.swift
//  contrast
//
//  Created by Александра Орлова on 13.07.2023.
//

import Foundation
import UIKit

final class SupportView: UIView {
    
    private let supportLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
        label.text = R.string.localizable.supportText()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.supportIcon())
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension SupportView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(imageView)
        addSubview(supportLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.width.equalTo(64)
            $0.centerX.equalToSuperview()
        }
        
        supportLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

