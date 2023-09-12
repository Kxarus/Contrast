//
//  NumberServices.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 11.07.2023.
//

import Foundation
import UIKit
import SnapKit

protocol ServiceViewDelegate: AnyObject {
    func authError()
    func setFavorite(id: Int, isFavorite: Bool)
    func refreshFullPrice()
}

final class ServiceView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular17
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textLight
        label.numberOfLines = 0
        label.font = GeneralFonts.generalRegular11
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular17
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textDark
        label.font = GeneralFonts.generalRegular15
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.setImage(R.image.favoriteService(), for: .normal)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusIcon(), for: .normal)
        return button
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(R.image.minus(), for: .normal)
        return button
    }()
    
    weak var delegate: ServiceViewDelegate?
    private var item: CatalogItemModel?
    private var isFavorite: Bool = false
    private var counter: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension ServiceView {
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(countLabel)
        addSubview(favoriteButton)
        addSubview(addButton)
        addSubview(removeButton)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(favoriteButton)
            $0.leading.equalTo(self).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.height.equalTo(40)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(addButton)
            $0.trailing.equalTo(addButton.snp.leading).offset(-12)
        }
        
        removeButton.snp.makeConstraints {
            $0.top.equalTo(addButton)
            $0.trailing.equalTo(countLabel.snp.leading).offset(-12)
            $0.width.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(countLabel)
            $0.leading.equalTo(descriptionLabel)
        }
    }
    
    @objc func addButtonTapped() {
        counter += 1
        LocalBasket.shared.addToBasket(productVariant: item!)
        updateView()
        delegate?.refreshFullPrice()
    }
    
    @objc func removeButtonTapped() {
        counter -= 1
        LocalBasket.shared.removeFromBasket(productVariant: item!)
        updateView()
        delegate?.refreshFullPrice()
    }
    
    @objc private func favoriteButtonTapped() {
        if UserDefaultsWorker.fetchActiveAccessToken() == nil {
            delegate?.authError()
        } else {
            isFavorite = !isFavorite
            delegate?.setFavorite(id: item!.id, isFavorite: isFavorite)
            
            if isFavorite {
                favoriteButton.setImage(R.image.favoriteServiceActive(), for: .normal)
            } else {
                favoriteButton.setImage(R.image.favoriteService(), for: .normal)
            }
        }
    }
    
    private func updateView() {
        countLabel.text = "\(counter) шт"
        if counter == 0 {
            countLabel.isHidden = true
            removeButton.isHidden = true
        } else {
            countLabel.isHidden = false
            removeButton.isHidden = false
        }
    }
}

// MARK: - Public methods
extension ServiceView {
    func setupView(item: CatalogItemModel) {
        self.item = nil
        counter = 0
        
        self.item = item
        
        let itemsInBasket = LocalBasket.shared.getItemsFromBasket()
        for itemInBasket in itemsInBasket {
            if itemInBasket.productVariant?.id == item.id {
                counter = itemInBasket.productCount
            }
        }
        
        updateView()
        
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        priceLabel.text = item.price.formattedString
        
        self.isFavorite = item.isFavorite
        isFavorite ? favoriteButton.setImage(R.image.favoriteServiceActive(), for: .normal) : favoriteButton.setImage(R.image.favoriteService(), for: .normal)
    }
}


