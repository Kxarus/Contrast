//
//  TechAsessmentView.swift
//  contrast
//
//  Created by Александра Орлова on 13.07.2023.
//

import Foundation
import UIKit

final class TechAsessmentView: UIView {
    
    private let waitingAsessmentLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium24
        label.textColor = UIColor.textDark
        label.text = R.string.localizable.waitingForAssessment()
        label.numberOfLines = 2
        return label
    }()
    
    private let accurateAsessmentLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textColor = UIColor.textLight
        label.text = R.string.localizable.accurateAssessment()
        label.numberOfLines = 2
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
extension TechAsessmentView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(waitingAsessmentLabel)
        addSubview(accurateAsessmentLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        waitingAsessmentLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        accurateAsessmentLabel.snp.makeConstraints {
            $0.top.equalTo(waitingAsessmentLabel.snp.bottom).offset(11)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

