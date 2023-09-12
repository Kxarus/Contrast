//
//  RegistrationOnTrustCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 05.07.2023.
//

import UIKit

protocol RegistrationOnTrustCellDelegate: AnyObject {
    func routeToQR()
    func routeToTrustArrangement()
}

final class RegistrationOnTrustCell: UITableViewCell, Reusable {
    
    private let containerView: ShadowView = {
        let view = ShadowView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular15
        label.text = R.string.localizable.registrationOnTrustTitle()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textLight
        label.font = GeneralFonts.generalRegular11
        label.text = R.string.localizable.registrationOnTrustDescription()
        label.numberOfLines = 2
        return label
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.setImage(R.image.registrationOnTrustIcon(), for: .normal)
        return button
    }()
    
    weak var delegate: RegistrationOnTrustCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PrivateMethods
private extension RegistrationOnTrustCell {
    private func setup() {
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(mainButton)
        
        mainButton.addTarget(self, action: #selector(pressMainButton), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressCell))
        containerView.addGestureRecognizer(gesture)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(mainButton.snp.leading).offset(-64)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        mainButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().priority(1000)
            $0.trailing.equalTo(containerView).inset(10)
            $0.width.equalTo(67)
            $0.height.equalTo(53)
            $0.top.bottom.greaterThanOrEqualTo(containerView).inset(10).priority(999)
        }
    }
    
    @objc private func pressMainButton() {
        delegate?.routeToQR()
    }
    
    @objc private func pressCell() {
        delegate?.routeToTrustArrangement()
    }
}
