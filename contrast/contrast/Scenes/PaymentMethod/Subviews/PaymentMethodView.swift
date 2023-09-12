//
//  PaymentMethodView.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//

import UIKit

final class PaymentMethodView: UIView {
    
    private let paymentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textLight()
        label.font = GeneralFonts.generalRegular11
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.arrowRight())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
extension PaymentMethodView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(paymentImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        paymentImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(paymentImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(4)
            $0.height.equalTo(15)
        }
    }
    
    private func setupTitleConstraints(withDesc: Bool) {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(paymentImageView.snp.trailing).offset(10)
            $0.height.equalTo(18)
            if withDesc {
                $0.top.equalTo(descriptionLabel.snp.bottom)
            } else {
                $0.top.equalToSuperview().offset(10)
            }
        }
    }
}

// MARK: - Public methods
extension PaymentMethodView {
    func setupView(title: String, desc: String, image: UIImage) {
        titleLabel.text = title
        descriptionLabel.text = desc
        paymentImageView.image = image
        setupTitleConstraints(withDesc: desc != "")
    }
}
