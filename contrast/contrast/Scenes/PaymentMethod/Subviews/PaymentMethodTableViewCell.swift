//
//  PaymentMethodTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//

import UIKit

protocol PaymentMethodTableViewCellDelegate: AnyObject {
    func cashTapped()
    func anotherCardsTapped()
    func mainCardTapped()
}

final class PaymentMethodTableViewCell: UITableViewCell, Reusable {
    
    private let mainCardView = PaymentMethodView()
    private let anotherCardView = PaymentMethodView()
    private let cashView = PaymentMethodView()
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textColor = UIColor.textLight
        label.text = R.string.localizable.choosePaymentType()
        label.textAlignment = .center
        return label
    }()
    
    weak var delegate: PaymentMethodTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension PaymentMethodTableViewCell {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        contentView.isUserInteractionEnabled = true
        addSubview(stackView)
        addSubview(headerLabel)

        cashView.setupView(title: R.string.localizable.cash(), desc: "", image: R.image.cashIcon()!)

        stackView.addArrangedSubview(mainCardView)
        stackView.addArrangedSubview(cashView)
        setupConstraints()
        setupGestures()
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(22)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        mainCardView.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        
        cashView.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        
        anotherCardView.snp.makeConstraints {
            $0.height.equalTo(45)
        }
    }
    
    private func setupGestures() {
        cashView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cashViewTapped)))
        mainCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainCardViewTapped)))
        anotherCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(anotherCardViewTapped)))
    }
    
    private func changeStack() {
        stackView.removeArrangedSubview(mainCardView)
        stackView.removeArrangedSubview(cashView)
        stackView.addArrangedSubview(mainCardView)
        stackView.addArrangedSubview(anotherCardView)
        stackView.addArrangedSubview(cashView)
    }
    
    @objc private func cashViewTapped() {
        delegate?.cashTapped()
    }
    
    @objc private func mainCardViewTapped() {
        delegate?.mainCardTapped()
    }
    
    @objc private func anotherCardViewTapped() {
        delegate?.anotherCardsTapped()
    }
}

// MARK: - Public methods
extension PaymentMethodTableViewCell {
    func setupCell(cards: [CardModel]?) {
        guard let cards = cards else {
            mainCardView.setupView(title: R.string.localizable.cardPayment(), desc: "", image: R.image.cardIcon()!)
            return
        }

        mainCardView.setupView(title: cards[0].num, desc: R.string.localizable.mainCard(), image: R.image.cardIcon()!)
        
        if cards.count > 1 {
            anotherCardView.setupView(title: R.string.localizable.cardNumber(String(cards.count)), desc: R.string.localizable.anotherCard(), image: R.image.cardIcon()!)
            changeStack()
        }
    }
}

