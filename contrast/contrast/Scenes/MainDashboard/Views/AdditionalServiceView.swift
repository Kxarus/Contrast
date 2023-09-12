//
//  NumberBonusServices.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 11.07.2023.
//

import Foundation
import UIKit
import SnapKit

final class AdditionalServiceView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = .textDark
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textColor = .textLight
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = GeneralFonts.generalRegular15
        label.textColor = .textDark
        return label
    }()
    
    private var discountImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.discountImage()
        return image
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusIcon(), for: .normal)
        return button
    }()
    
    weak var delegate: ServiceViewDelegate?
    private var counter: Int = 0
    private var serviceId = 0
    private var additionalServiceId = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension AdditionalServiceView {
    private func setup() {
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(costLabel)
        addSubview(discountImage)
        addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        discountImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(18)
            $0.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(discountImage)
            $0.leading.equalTo(discountImage.snp.trailing).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
        }
        
        costLabel.snp.makeConstraints {
            $0.centerY.equalTo(addButton)
            $0.trailing.equalTo(addButton.snp.leading).offset(-12)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(discountImage)
            $0.width.height.equalTo(40)
        }
    }
    @objc private func addButtonTapped() {
        if counter == 0 {
            counter += 1
            addButton.setImage(R.image.additionalServiceCancel(), for: .normal)
            LocalBasket.shared.addToBasket(productVariantId: serviceId, additionalServiceId: additionalServiceId)
            delegate?.refreshFullPrice()
        } else {
            counter -= 1
            addButton.setImage(R.image.plusIcon(), for: .normal)
            LocalBasket.shared.removeFromBasket(productVariantId: serviceId, additionalServiceId: additionalServiceId)
            delegate?.refreshFullPrice()
        }
    }
}

// MARK: - Public methods
extension AdditionalServiceView {
    
    func setupView(serviceId: Int, id: Int, title: String, description: String, cost: Float) {
        titleLabel.text = ""
        descriptionLabel.text = ""
        costLabel.text = ""
        counter = 0
        self.serviceId = 0
        self.additionalServiceId = 0
        
        self.serviceId = serviceId
        self.additionalServiceId = id
        
        let itemsInBasket = LocalBasket.shared.getItemsFromBasket()
        for itemInBasket in itemsInBasket {
            if itemInBasket.productVariant?.id == serviceId {
                for addService in itemInBasket.productVariant!.additionalServices {
                    if addService.id == id {
                        counter = addService.count
                    }
                }
            }
        }
        
        if counter == 0 {
            addButton.setImage(R.image.plusIcon(), for: .normal)
        } else {
            addButton.setImage(R.image.additionalServiceCancel(), for: .normal)
        }
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        costLabel.text = cost.formattedString
    }
}
