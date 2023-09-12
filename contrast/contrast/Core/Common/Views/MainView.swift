//
//  TypeView.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 14.07.2023.
//

import Foundation
import UIKit

protocol ChangeViewDelegate: AnyObject {
    func routeTo(type: ScreenType)
}

enum ScreenType {
    case timeSlotSelection
    case addPhotos
}

final class ChangeView: UIView {
    
    //     MARK: - IBOutlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular15
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = R.image.arrowForward()
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular15
        return label
    }()
    
    private var additionalDescription: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = .textDark
        label.isHidden = true
        return label
    }()
    
    weak var delegate: ChangeViewDelegate?
    private var screenType: ScreenType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension ChangeView {
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(imageView)
        
        setupTapGestureRecognizers()
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        })
        
        imageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        })
    }
    
    private func setupTapGestureRecognizers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handletimeSlotSelectionViewTap))
        addGestureRecognizer(gesture)
    }
    
    @objc private func handletimeSlotSelectionViewTap() {
        delegate?.routeTo(type: screenType!)
    }
}

// MARK: - Public methods
extension ChangeView {
    
    func setupView(sectionString: String, screenType: ScreenType) {
        titleLabel.text = sectionString
        self.screenType = screenType
    }
    
    func setupChangeView(descriptionText: String, hideImage: Bool = false) {
        
        imageView.isHidden = hideImage
        additionalDescription.text = descriptionText
        additionalDescription.isHidden = false
        titleLabel.font = GeneralFonts.generalRegular11
        titleLabel.textColor = .textLight
        
        addSubview(additionalDescription)
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(18)
        }
        
        additionalDescription.snp.makeConstraints{
            $0.top.equalTo(titleLabel).offset(12)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview()
        }
    }
}

