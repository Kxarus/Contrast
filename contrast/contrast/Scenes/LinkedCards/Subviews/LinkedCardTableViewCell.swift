//
//  LinkedCardTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//

import UIKit

final class LinkedCardTableViewCell: UITableViewCell, Reusable {
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.arrowRight())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension LinkedCardTableViewCell {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        contentView.isUserInteractionEnabled = true
        addSubview(titleLabel)
        addSubview(arrowImageView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }
}

// MARK: - Public methods
extension LinkedCardTableViewCell {
    func setupCell(model: CardModel) {
        titleLabel.text = model.num
    }
}

