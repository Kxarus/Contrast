//
//  OrderValueView.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 06.07.2023.
//

import Foundation
import UIKit
import SnapKit

protocol OrderValueViewDelegate: AnyObject {
    func routeToMap()
}

final class OrderValueView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBackgroundColor
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private let costInformationLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.costBeforeEstimate()
        label.numberOfLines = 0
        label.font = GeneralFonts.generalRegular11
        label.textColor = .textLight
        return label
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium17
        label.textColor = .textDark
        return label
    }()
    
    private let makeOrderButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.makeOrder(), for: .normal)
        button.isEnabledButton = false
        return button
    }()
    
    weak var delegate: OrderValueViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension OrderValueView {
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(costInformationLabel)
        containerView.addSubview(costLabel)
        containerView.addSubview(makeOrderButton)
        
        makeOrderButton.addTarget(self, action: #selector(pressMakeOrderButton), for: .touchUpInside)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        containerView.snp.makeConstraints({
            $0.edges.equalTo(self)
        })
        
        costInformationLabel.snp.makeConstraints({
            $0.top.equalTo(containerView).inset(14)
            $0.leading.equalTo(containerView).inset(14)
        })
        
        costLabel.snp.makeConstraints({
            $0.top.equalTo(costInformationLabel.snp.bottom)
            $0.leading.equalTo(containerView).inset(14)
            $0.trailing.equalTo(makeOrderButton).offset(18)
        })
        
        makeOrderButton.snp.makeConstraints({
            $0.top.equalTo(containerView).offset(14)
            $0.bottom.equalTo(containerView).inset(14)
            $0.trailing.equalTo(containerView).inset(14)
            $0.height.equalTo(37)
            $0.width.equalTo(96)
        })
    }
    
    @objc private func pressMakeOrderButton() {
        delegate?.routeToMap()
    }
}

// MARK: - Public methods
extension OrderValueView {
    func setupView() {
        let price = LocalBasket.shared.calcBasket()
        
        if price > 0 {
            costLabel.text = R.string.localizable.from() + " " + price.formattedString + " ₽"
            makeOrderButton.isEnabledButton = true
        } else {
            costLabel.text = ""
            makeOrderButton.isEnabledButton = false
        }
    }
}
