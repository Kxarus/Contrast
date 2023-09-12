//
//  PaymentConfirmationViewController.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PaymentConfirmationDisplayLogic: AnyObject {
    func display(viewModel: PaymentConfirmation.Model.ViewModel.ViewModelType)
}

final class PaymentConfirmationViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.paymentConfirmation()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalMedium34
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalRegular15
        label.numberOfLines = 0
        return label
    }()
    
    private let finalSumLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalMedium64
        return label
    }()
    
    private let cancelButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.cancel(), for: .normal)
        return button
    }()
    
    private let confirmButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        return button
    }()
    
    // MARK: - External vars
    var interactor: PaymentConfirmationBusinessLogic?
    var router: (NSObjectProtocol & PaymentConfirmationRoutingLogic & PaymentConfirmationDataPassing)?
    
    // MARK: - Internal vars
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        PaymentConfirmationConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PaymentConfirmationConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Display logic
extension PaymentConfirmationViewController: PaymentConfirmationDisplayLogic {
    
    func display(viewModel: PaymentConfirmation.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension PaymentConfirmationViewController {
    private func setupView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.mainBackgroundColor
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(finalSumLabel)
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        
        setupConstraints()
        setAttributedStrings()
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }
    
    private func setAttributedStrings() {
        guard let orderNum = router?.dataStore?.order?.number, let orderSum = router?.dataStore?.order?.sum, let orderCard = router?.dataStore?.order?.card?.num else { return }
        
        subtitleLabel.text = R.string.localizable.orderInfo(orderCard, orderNum)
        finalSumLabel.text = R.string.localizable.finalSum(orderSum.formattedString)
        
        let fullText = String(format: NSLocalizedString("orderInfo", comment: ""), orderCard, orderNum)
        let attributedText = NSMutableAttributedString(string: fullText)

        attributedText.addAttribute(.foregroundColor, value: UIColor.textTone, range: NSRange(location: 0, length: fullText.count))
        let orderCardRange = (fullText as NSString).range(of: orderCard)
        let orderNumRange = (fullText as NSString).range(of: orderNum)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.textDark2, range: orderCardRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.textDark2, range: orderNumRange)
        subtitleLabel.attributedText = attributedText
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(87)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
        }
        
        finalSumLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.medium)
            $0.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(30).priority(.high)
            $0.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
            $0.bottom.equalTo(confirmButton.snp.top).offset(-10)
        }
    }
    
    @objc private func cancelTapped() {
        router?.routeBack()
    }
    
    @objc private func confirmTapped() {
        router?.routeToPay()
    }
}

// MARK: - Public methods
extension PaymentConfirmationViewController {
    
}


