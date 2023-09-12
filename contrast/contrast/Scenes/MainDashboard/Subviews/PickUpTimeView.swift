//
//  PickUpTimeView.swift
//  contrast
//
//  Created by Александра Орлова on 11.07.2023.
//

import UIKit

final class PickUpTimeView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = UIColor.textLight
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium24
        label.textColor = UIColor.textDark
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
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
extension PickUpTimeView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-10)
            $0.bottom.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}

// MARK: - Public methods
extension PickUpTimeView {
    func setupView(date: String, time: String) {
        dateLabel.text = date
        timeLabel.text = time
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}

