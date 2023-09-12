//
//  AddressCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 19.07.2023.
//

import UIKit

final class AddressCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackgroundColor
        view.layer.cornerRadius = 26
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular13
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.checkMarkBlackIcon()
        imageView.isHidden = true
        return imageView
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
private extension AddressCollectionViewCell {
    func setupView() {
        backgroundColor = .mainBackgroundColor
        layer.cornerRadius = 26
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

//MARK: - Public methods
extension AddressCollectionViewCell {
    func setupCell(model: UserAddressModel) {
        titleLabel.text = model.street + " " + model.house
        if model.isActive {
            containerView.backgroundColor = .accent
            imageView.isHidden = false
            
            titleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(15)
                $0.leading.equalTo(imageView.snp.trailing).offset(6)
                $0.trailing.equalToSuperview().inset(20)
            }
        } else {
            containerView.backgroundColor = .mainBackgroundColor
            imageView.isHidden = true
            
            titleLabel.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(15)
                $0.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }
}

