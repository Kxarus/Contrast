//
//  ServicesCell.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 12.07.2023.
//

import Foundation
import UIKit

protocol ServiceTableViewCellDelegate: AnyObject {
    func errorAuth()
    func setFavorite(id: Int, isFavorite: Bool)
    func refreshFullPrice()
}

final class ServiceTableViewCell: UITableViewCell, Reusable {
    
    private let containerView: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let serviceView: ServiceView = {
        let service = ServiceView()
        return service
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .borderLight
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    weak var delegate: ServiceTableViewCellDelegate?
    private var catalogItem: CatalogItemModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension ServiceTableViewCell {
    private func setup() {
        contentView.isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.addSubview(serviceView)
        
        serviceView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        serviceView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(3)
            $0.trailing.equalToSuperview().inset(3)
            $0.bottom.equalToSuperview().inset(3)
        }
    }
}

//MARK: - Public methods
extension ServiceTableViewCell {
    
    func setupCell(with item: CatalogItemModel) {
        catalogItem = nil
        
        catalogItem = item
        serviceView.setupView(item: item)
        
        separatorView.removeFromSuperview()
        stackView.removeFromSuperview()
        stackView.removeAllArrangedViews()
        
        serviceView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(3)
            $0.trailing.equalToSuperview().inset(3)
            $0.bottom.equalToSuperview().inset(3)
        }
        
        let itemsInBasket = LocalBasket.shared.getItemsFromBasket()
        for itemInBasket in itemsInBasket {
            if itemInBasket.productVariant?.id == item.id {
                if itemInBasket.productCount > 0 {
                    if !item.additionalServices.isEmpty {
                        
                        serviceView.snp.remakeConstraints {
                            $0.top.equalToSuperview().inset(3)
                            $0.leading.equalToSuperview().inset(3)
                            $0.trailing.equalToSuperview().inset(3)
                        }
                        
                        addSubview(separatorView)
                        separatorView.snp.makeConstraints {
                            $0.top.equalTo(serviceView.snp.bottom).inset(4)
                            $0.leading.trailing.equalToSuperview().inset(32)
                            $0.height.equalTo(1)
                        }
                        addSubview(stackView)
                        stackView.snp.makeConstraints {
                            $0.top.equalTo(separatorView.snp.bottom).offset(10)
                            $0.leading.trailing.equalToSuperview().inset(16)
                            $0.bottom.equalToSuperview().inset(20)
                        }
                        
                        for additionalService in item.additionalServices {
                            let view = AdditionalServiceView()
                            view.setupView(serviceId: item.id,
                                           id: additionalService.id,
                                           title: additionalService.title,
                                           description: additionalService.description,
                                           cost: additionalService.price)
                            view.delegate = self
                            stackView.addArrangedSubview(view)
                        }
                    }
                }
            }
        }
    }
}

//MARK: - ServiceView Delegate
extension ServiceTableViewCell: ServiceViewDelegate {
    func refreshFullPrice() {
        delegate?.refreshFullPrice()
    }
    
    func authError() {
        delegate?.errorAuth()
    }
    
    func setFavorite(id: Int, isFavorite: Bool) {
        delegate?.setFavorite(id: id, isFavorite: isFavorite)
    }
}
