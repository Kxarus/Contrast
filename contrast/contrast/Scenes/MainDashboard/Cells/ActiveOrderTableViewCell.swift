//
//  ActiveOrderTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 11.07.2023.
//

import UIKit

protocol ActiveOrderTableViewCellDelegate: AnyObject {
    func routeToPay()
    func rejectOrder()
    func routeToReciept()
    func routeToBarcode()
    func routeToTimeSlots()
    func routeToEstimate()
    func routeToMap()
}

final class ActiveOrderTableViewCell: UITableViewCell, Reusable {
    
    private let container: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 14
        return stack
    }()
    
    private let firstSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.borderCard
        return view
    }()
    
    private let secondSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.borderCard
        return view
    }()
    
    private let chooseTimeLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textColor = UIColor.textDark
        label.text = R.string.localizable.choosePickupTime()
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.arrowRight())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusView = StatusView()
    private let pickupTimeView = PickUpTimeView()
    private let returnTimeView = PickUpTimeView()
    private let orderSumView = OrderSumView()
    private let agreementView = AgreementView()
    private let choosePickupTimeView = UIView()
    private let supportView = SupportView()
    private let estimateView = EstimateView()
    private let pickupPointView = PickupPointView()
    private let techAsessmentView = TechAsessmentView()

    weak var delegate: ActiveOrderTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension ActiveOrderTableViewCell {
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = R.color.mainBackgroundColor()
        addSubview(container)
        container.addSubview(stackView)
        setupConstraints()
        
        statusView.delegate = self
        agreementView.delegate = self
        estimateView.delegate = self
        pickupPointView.delegate = self
        
        choosePickupTimeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(routeToTimeSlots)))
    }
    
    private func setupStack(withStatus status: OrderStatus, paymentType type: PaymentType?, hasDelivery: Bool) {
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(firstSeparatorView)
        
        switch status {
        case .created:
            pickupTimeView.set(title: R.string.localizable.pickUpTitle())
            stackView.addArrangedSubview(hasDelivery ? pickupTimeView : techAsessmentView)
        case .onWay:
            pickupTimeView.set(title: R.string.localizable.pickUpTitle())
            stackView.addArrangedSubview(pickupTimeView)
        case .agreement:
            orderSumView.set(title: R.string.localizable.pay())
            stackView.addArrangedSubview(orderSumView)
            stackView.addArrangedSubview(agreementView)
        case .keeping:
            pickupTimeView.set(title: R.string.localizable.desiredPickupTime())
            orderSumView.set(title: type == .card ? R.string.localizable.payed() : R.string.localizable.courierPay())
            
            stackView.addArrangedSubview(pickupTimeView)
            stackView.addArrangedSubview(secondSeparatorView)
            stackView.addArrangedSubview(orderSumView)
        case .rejected:
            orderSumView.set(title: R.string.localizable.canceled())
            stackView.addArrangedSubview(orderSumView)
            stackView.addArrangedSubview(supportView)
        case .approved, .inProgress:
            orderSumView.set(title: type == .card ? R.string.localizable.payed() : R.string.localizable.courierPay())
            stackView.addArrangedSubview(orderSumView)
        case .refund:
            stackView.addArrangedSubview(choosePickupTimeView)
        case .ready:
            orderSumView.set(title: type == .card ? R.string.localizable.payed() : R.string.localizable.courierPay())
            stackView.addArrangedSubview(orderSumView)
            stackView.addArrangedSubview(secondSeparatorView)
            stackView.addArrangedSubview(hasDelivery ? choosePickupTimeView : pickupPointView)
        case .done:
            pickupTimeView.set(title: R.string.localizable.wasPickedUp())
            returnTimeView.set(title: R.string.localizable.wasPickedUp())
            orderSumView.set(title: type == .card ? R.string.localizable.payed() : R.string.localizable.courierPay())
            
            stackView.addArrangedSubview(pickupTimeView)
            stackView.addArrangedSubview(returnTimeView)
            stackView.addArrangedSubview(secondSeparatorView)
            stackView.addArrangedSubview(orderSumView)
            stackView.addArrangedSubview(estimateView)
        default:
            break
        }
    }
    
    private func setupConstraints() {
        container.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        firstSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        secondSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        choosePickupTimeView.addSubview(chooseTimeLabel)
        choosePickupTimeView.addSubview(arrowImageView)
        
        chooseTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-5)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }
    
    @objc private func routeToTimeSlots() {
        delegate?.routeToTimeSlots()
    }
}

// MARK: - Public methods
extension ActiveOrderTableViewCell {
    func setupCell(model: OrderModel) {
        stackView.removeAllArrangedViews()
        setupStack(withStatus: model.status, paymentType: model.paymentType, hasDelivery: model.hasDelivery)
        statusView.setupView(withOrder: model)
        pickupTimeView.setupView(date: model.pickupDate, time: model.pickupTime)
        returnTimeView.setupView(date: model.deliveryDate, time: model.deliveryTime)
        estimateView.setupView(estimate: model.estimate)
        orderSumView.setupView(withOrder: model)
        if !model.hasDelivery && model.status == .created {
            pickupPointView.setupView(model: model)
        }
    }
}

// MARK: - AgreementViewDelegate
extension ActiveOrderTableViewCell: AgreementViewDelegate {
    func rejectTapped() {
        delegate?.rejectOrder()
    }
    
    func payTapped() {
        delegate?.routeToPay()
    }
}

// MARK: - StatusViewDelegate
extension ActiveOrderTableViewCell: StatusViewDelegate {
    func routeToReciept() {
        delegate?.routeToReciept()
    }
    
    func routeToBarcode() {
        delegate?.routeToBarcode()
    }
}

// MARK: - EstimateViewDelegate
extension ActiveOrderTableViewCell: EstimateViewDelegate {
    func estimateOrder() {
        delegate?.routeToEstimate()
    }
}

// MARK: - PickupPointViewDelegate
extension ActiveOrderTableViewCell: PickupPointViewDelegate {
    func routeToMap() {
        delegate?.routeToMap()
    }
}
