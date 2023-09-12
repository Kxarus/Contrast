//
//  StatusView.swift
//  contrast
//
//  Created by Александра Орлова on 11.07.2023.
//

import UIKit

protocol StatusViewDelegate: AnyObject {
    func routeToReciept()
    func routeToBarcode()
}

final class StatusView: UIView {
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular12
        label.textColor = UIColor.black
        return label
    }()
    
    private let orderStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.accent
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let recieptLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = UIColor.textDark
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = UIColor.textDark
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let recieptButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.recieptIcon(), for: .normal)
        return button
    }()
    
    private let barcodeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.barcodeIcon(), for: .normal)
        return button
    }()
    
    weak var delegate: StatusViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension StatusView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(orderStatusView)
        addSubview(orderLabel)
        addSubview(recieptLabel)
        addSubview(recieptButton)
        addSubview(barcodeButton)
        orderStatusView.addSubview(statusLabel)
        
        recieptButton.addTarget(self, action: #selector(recieptButtonTapped), for: .touchUpInside)
        barcodeButton.addTarget(self, action: #selector(barcodeButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        orderStatusView.snp.removeConstraints()
        orderStatusView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(statusLabel).offset(26)
            $0.height.equalTo(27)
            
            if recieptLabel.isHidden {
                $0.bottom.equalToSuperview().inset(5)
            }
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        recieptLabel.snp.makeConstraints {
            $0.top.equalTo(orderStatusView.snp.bottom).offset(16).priority(.required)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(barcodeButton.snp.leading).offset(-10)
        }
        
        orderLabel.snp.makeConstraints {
            $0.top.equalTo(recieptLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(barcodeButton.snp.leading).offset(-10)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        recieptButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        barcodeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.trailing.equalTo(recieptButton.snp.leading).offset(-12)
            $0.width.height.equalTo(44)
        }
    }
    
    @objc private func recieptButtonTapped() {
        delegate?.routeToReciept()
    }
    
    @objc private func barcodeButtonTapped() {
        delegate?.routeToBarcode()
    }
}

// MARK: - Public methods
extension StatusView {
    func setupView(withOrder order: OrderModel) {
        orderLabel.isHidden = false
        recieptLabel.isHidden = false
        recieptButton.isHidden = false
        barcodeButton.isHidden = false
        
        switch order.status {
        case .created:
            recieptLabel.isHidden = true
            orderLabel.isHidden = true
            recieptButton.isHidden = true
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.created()
        case .onWay:
            recieptLabel.isHidden = true
            orderLabel.isHidden = true
            recieptButton.isHidden = true
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.onWay()
        case .agreement:
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.agreement()
        case .approved:
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.approved()
        case .rejected:
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.rejected()
        case .refund:
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.refund()
        case .inProgress:
            barcodeButton.isHidden = true
            statusLabel.text = R.string.localizable.inProgress()
        case .ready:
            statusLabel.text = R.string.localizable.ready()
        case .keeping:
            statusLabel.text = R.string.localizable.keeping()
        case .done:
            statusLabel.text = R.string.localizable.done()
        }
        
        recieptLabel.text = R.string.localizable.recieptNumber(order.reciept)
        orderLabel.text = R.string.localizable.orderNumber(order.orderNumber)
        setupConstraints()
    }
}
