//
//  NewOrderTableViewCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 04.07.2023.
//

import UIKit

protocol NewOrderTableViewCellDelegate: AnyObject {
    func routeToNewOrder()
}

final class NewOrderTableViewCell: UITableViewCell, Reusable {

    private let containerView: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let newOrderIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.newOrderIcon()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular17
        label.text = R.string.localizable.newOrderTitle()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textLight
        label.font = GeneralFonts.generalRegular11
        label.text = R.string.localizable.newOrderDescription()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.arrangeDelivery(), for: .normal)
        return button
    }()
    
    weak var delegate: NewOrderTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PrivateMethods
private extension NewOrderTableViewCell {
    private func setup() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.addSubview(newOrderIcon)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(mainButton)
        
        mainButton.addTarget(self, action: #selector(pressMainButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        newOrderIcon.snp.makeConstraints {
            $0.top.equalTo(containerView).inset(24)
            $0.centerX.equalTo(containerView)
            $0.width.height.equalTo(96)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(newOrderIcon.snp.bottom).offset(15)
            $0.centerX.equalTo(containerView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(containerView)
            $0.leading.trailing.equalTo(containerView).inset(16)
        }
        
        mainButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(33)
            $0.leading.trailing.bottom.equalTo(containerView).inset(16)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func pressMainButton() {
        delegate?.routeToNewOrder()
    }
}
