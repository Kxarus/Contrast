//
//  PincodeCollectionViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 29.06.2023.
//

import UIKit

class PincodeCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "PincodeCollectionViewCell"
    
    let digitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.color.textDark2()
        label.font = GeneralFonts.generalRegular36
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupCell()
    }
}


// MARK: - Private methods
private extension PincodeCollectionViewCell {
    private func setupCell() {
        contentView.clipsToBounds = true
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.addSubview(digitLabel)
        digitLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Public methods
extension PincodeCollectionViewCell {
    func setupDigit(_ digit: String) {
        contentView.backgroundColor = R.color.secondaryButtonColor()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = R.color.borderLight()?.cgColor
        contentView.layer.cornerRadius = contentView.bounds.width / 2
        digitLabel.text = digit
    }
    
    func setupFaceIdIcon(hidden: Bool) {
        if !hidden {
            let image = R.image.faceIdIcon()
            let view = UIImageView(image: image)
            view.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
            self.addSubview(view)
        }
    }
    
    func setupClearIcon() {
        let image = R.image.clearIcon()
        let view = UIImageView(image: image)
        view.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        self.addSubview(view)
    }
}

