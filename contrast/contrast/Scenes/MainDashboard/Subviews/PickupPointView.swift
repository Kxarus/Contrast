//
//  PickupPointView.swift
//  contrast
//
//  Created by Александра Орлова on 13.07.2023.
//

import Foundation
import UIKit

protocol PickupPointViewDelegate: AnyObject {
    func routeToMap()
}

final class PickupPointView: UIView {
    
    private let readyLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
        label.text = R.string.localizable.pickupReady()
        label.numberOfLines = 2
        return label
    }()
    
    private let adressLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textColor = UIColor.textLight
        return label
    }()
    
    private let freeUntilLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular12
        label.textColor = UIColor.textDark
        return label
    }()
    
    private let mapButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.showOnMap(), for: .normal)
        button.setupStyle(style: .border())
        button.titleLabel?.font = GeneralFonts.generalRegular11
        return button
    }()
    
    weak var delegate: PickupPointViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension PickupPointView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(readyLabel)
        addSubview(adressLabel)
        addSubview(freeUntilLabel)
        addSubview(mapButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        readyLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalTo(mapButton.snp.leading).offset(-10)
        }
        
        adressLabel.snp.makeConstraints {
            $0.top.equalTo(readyLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(mapButton.snp.leading).offset(-10)
        }
        
        freeUntilLabel.snp.makeConstraints {
            $0.top.equalTo(adressLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(130)
        }
        
        mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
    }
    
    @objc private func mapButtonTapped() {
        delegate?.routeToMap()
    }
}

// MARK: - Public methods
extension PickupPointView {
    func setupView(model: OrderModel) {
        adressLabel.text = model.pickupPointAdress
        freeUntilLabel.text = R.string.localizable.freeUnil(model.pickupPointDate)
    }
}

