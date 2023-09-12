//
//  EstimateView.swift
//  contrast
//
//  Created by Александра Орлова on 13.07.2023.
//

import Foundation
import UIKit

protocol EstimateViewDelegate: AnyObject {
    func estimateOrder()
}

final class EstimateView: UIView {
    
    private let supportLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
        label.text = R.string.localizable.helpMessage()
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.estimateIcon())
        return imageView
    }()
    
    private let estimateButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.estimateOrder(), for: .normal)
        button.setupStyle(style: .fill)
        return button
    }()
    
    private let starsStack = StarsStackView()
    
    weak var delegate: EstimateViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension EstimateView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
    }
    
    private func setupEstimateOrderView() {
        addSubview(imageView)
        addSubview(supportLabel)
        addSubview(estimateButton)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.width.equalTo(64)
            $0.centerX.equalToSuperview()
        }
        
        supportLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        estimateButton.snp.makeConstraints {
            $0.top.equalTo(supportLabel.snp.bottom).offset(20)
            $0.height.equalTo(46)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        estimateButton.addTarget(self, action: #selector(estimateButtonTapped), for: .touchUpInside)
    }
    
    private func setupStars(count: Int) {
        addSubview(starsStack)
        starsStack.colorStars(count: count)
        
        starsStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(36)
            $0.width.equalTo(240)
        }
    }
    
    @objc private func estimateButtonTapped() {
        delegate?.estimateOrder()
    }
}

// MARK: - Public methods
extension EstimateView {
    func setupView(estimate: Int) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        if estimate == 0 {
            setupEstimateOrderView()
        } else {
            setupStars(count: estimate)
        }
    }
}
