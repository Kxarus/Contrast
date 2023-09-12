//
//  OrderSumView.swift
//  contrast
//
//  Created by Александра Орлова on 12.07.2023.
//

import UIKit

final class OrderSumView: UIView {
    
    private let fullSumLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular12
        label.textColor = UIColor.textLight
        return label
    }()
    
    private let sumWithDiscountLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium32
        label.textColor = UIColor.textDark
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textColor = UIColor.textLight
        return label
    }()
    
    private let paymentStatusLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
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
extension OrderSumView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(fullSumLabel)
        addSubview(sumWithDiscountLabel)
        addSubview(paymentStatusLabel)
        addSubview(discountLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        fullSumLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
        }
        
        sumWithDiscountLabel.snp.makeConstraints {
            $0.top.equalTo(fullSumLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        discountLabel.snp.makeConstraints {
            $0.top.equalTo(sumWithDiscountLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        paymentStatusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}

// MARK: - Public methods
extension OrderSumView {
    func setupView(withOrder order: OrderModel) {
        let attributedText = NSAttributedString(
            string: R.string.localizable.finalSum(order.sum.formattedString),
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        let discount: Float = 5.0
        let sumWithDiscount = order.sum * (100.0 - discount) / 100.0
        fullSumLabel.attributedText = attributedText
        discountLabel.text = R.string.localizable.personalDiscount(discount.formattedString)
        sumWithDiscountLabel.text = R.string.localizable.finalSum(sumWithDiscount.formattedString)
    }
    
    func set(title: String) {
        paymentStatusLabel.text = title
    }
}

