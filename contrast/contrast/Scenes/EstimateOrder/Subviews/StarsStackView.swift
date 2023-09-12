//
//  StarsStackView.swift
//  contrast
//
//  Created by Александра Орлова on 04.07.2023.
//

import UIKit

protocol StarsStackViewDelegate: AnyObject {
    func changeRate(rate: Int)
}

final class StarsStackView: UIStackView {
    
    var rate = 0
    
    weak var delegate: StarsStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension StarsStackView {
    private func setupStackView() {
        self.axis = .horizontal
        self.contentMode = .center
        self.distribution = .fillEqually
        for _ in 1...5 {
            let starButton = UIButton()
            starButton.setBackgroundImage(UIImage(resource: R.image.inactiveStar), for: .normal)
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            self.addArrangedSubview(starButton)
            self.setCustomSpacing(12, after: starButton)
        }
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        guard let tappedIndex = self.arrangedSubviews.firstIndex(of: sender) else {
            return
        }
        
        rate = tappedIndex
        for i in 0...4 {
            let view = self.arrangedSubviews[i] as? UIButton
            let image = i <= tappedIndex ? UIImage(resource: R.image.activeStar) : UIImage(resource: R.image.inactiveStar)
            view?.setBackgroundImage(image, for: .normal)
        }
        
        delegate?.changeRate(rate: rate + 1)
    }
}

extension StarsStackView {
    func colorStars(count: Int) {
        for i in 0...4 {
            let view = self.arrangedSubviews[i] as? UIButton
            view?.isUserInteractionEnabled = false
            let image = i < count ? UIImage(resource: R.image.activeStar) : UIImage(resource: R.image.inactiveStar)
            view?.setBackgroundImage(image, for: .normal)
        }
    }
}

