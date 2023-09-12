//
//  DatesCollectionViewCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 06.07.2023.
//

import UIKit

class DatesCollectionViewCell: UICollectionViewCell {
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalMedium17
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular11
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension DatesCollectionViewCell {
    private func setupView() {
        backgroundColor = .mainBackgroundColor
        layer.cornerRadius = 5
        
        addSubview(dayLabel)
        addSubview(monthLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: - Public methods
extension DatesCollectionViewCell {
    func setupCell(model: TimeIntervalModel) {
        dayLabel.text = model.day
        monthLabel.text = model.month.firstCharacterUpperCase()
        
        if model.isActive {
            backgroundColor = .accent
            layer.borderWidth = 0
        } else {
            backgroundColor = .mainBackgroundColor
            layer.borderWidth = 1
            layer.borderColor = UIColor.borderLight.cgColor
        }
    }
}
