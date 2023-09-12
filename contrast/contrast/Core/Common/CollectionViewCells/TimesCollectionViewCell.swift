//
//  TimesCollectionViewCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 06.07.2023.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular13
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
private extension TimesCollectionViewCell {
    private func setupView() {
        backgroundColor = .mainBackgroundColor
        layer.cornerRadius = 5
        
        addSubview(timeLabel)
        setupConstrains()
    }
    
    private func setupConstrains() {
        timeLabel.snp.makeConstraints {
            $0.centerY.centerX.equalTo(self)
            $0.leading.trailing.equalTo(self).inset(16)
        }
    }
}

//MARK: - Public methods
extension TimesCollectionViewCell {
    func setupCell(model: IntervalModel) {
        timeLabel.text = "\(model.timeStarts) - \(model.timeFinish)"
        
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
