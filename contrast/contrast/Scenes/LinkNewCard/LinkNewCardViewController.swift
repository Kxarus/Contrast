//
//  LinkNewCardViewController.swift
//  contrast
//
//  Created by Александра Орлова on 07.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LinkNewCardDisplayLogic: AnyObject {
    func display(viewModel: LinkNewCard.Model.ViewModel.ViewModelType)
}

final class LinkNewCardViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - IBOutlets
    private let cardImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.cardImage())
        return imageView
    }()
    
    private let confirmButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        return button
    }()
    
    private let holdMoneyLabel: UILabel = {
        let label = UILabel()
        let fullText = R.string.localizable.holdMoney()
        let attributedText = NSMutableAttributedString(string: fullText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.textLight, range: NSRange(location: 0, length: fullText.count))
        let range = (fullText as NSString).range(of: "1₽")
        attributedText.addAttribute(.foregroundColor, value: UIColor.textDark, range: range)
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = GeneralFonts.generalRegular10
        return label
    }()
    
    private let connectionLabel: UILabel = {
        let label = UILabel()
        let fullText = R.string.localizable.securityConnectionMessage()
        let attributedText = NSMutableAttributedString(string: fullText)
        attributedText.addAttribute(.foregroundColor, value: UIColor.textLight, range: NSRange(location: 0, length: fullText.count))
        let range = (fullText as NSString).range(of: "PSI DSS")
        attributedText.addAttribute(.foregroundColor, value: UIColor.textDark, range: range)
        label.attributedText = attributedText
        label.font = GeneralFonts.generalRegular10
        label.textAlignment = .center
        return label
    }()
    
    private let cardNumberTextField: MainTextField = {
        let textField = MainTextField()
        textField.setupView(typeView: .cardNumber, codeText: R.string.localizable.cardFullNum(), placeHolder: "0000 0000 0000 0000")
        return textField
    }()
    
    private let periodTextField: MainTextField = {
        let textField = MainTextField()
        textField.setupView(typeView: .validityPeriod, codeText: R.string.localizable.validityPeriod(), placeHolder: "00/00")
        return textField
    }()
    
    private let cvcTextField: MainTextField = {
        let textField = MainTextField()
        textField.setupView(typeView: .cvc, codeText: R.string.localizable.cvc(), placeHolder: "000")
        return textField
    }()
    
    // MARK: - External vars
    var interactor: LinkNewCardBusinessLogic?
    var router: (NSObjectProtocol & LinkNewCardRoutingLogic & LinkNewCardDataPassing)?
    
    // MARK: - Internal vars
    private var cardNumber: String?
    private var period: String?
    private var cvc: String?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LinkNewCardConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LinkNewCardConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Display logic
extension LinkNewCardViewController: LinkNewCardDisplayLogic {
    
    func display(viewModel: LinkNewCard.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension LinkNewCardViewController {
    private func setupView() {
        setupDissmisKeyboard()
        setupNavBar(withTitle: R.string.localizable.linkCard())
        cardNumberTextField.delegate = self
        periodTextField.delegate = self
        cvcTextField.delegate = self
        
        view.backgroundColor = UIColor.mainBackgroundColor
        view.addSubview(cardImageView)
        view.addSubview(confirmButton)
        view.addSubview(holdMoneyLabel)
        view.addSubview(connectionLabel)
        view.addSubview(cardNumberTextField)
        view.addSubview(cvcTextField)
        view.addSubview(periodTextField)
        setupConstraints()
        confirmButton.addTarget(self, action: #selector(saveCredits), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        cardNumberTextField.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        cardImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalTo(280)
            $0.height.equalTo(169)
        }
        
        periodTextField.snp.makeConstraints {
            $0.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(52)
            $0.width.equalTo((view.frame.width / 2) - 22)
        }
        
        cvcTextField.snp.makeConstraints {
            $0.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            $0.leading.equalTo(periodTextField.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.width.equalTo((view.frame.width / 2) - 22)
        }
        
        connectionLabel.snp.makeConstraints {
            $0.top.equalTo(periodTextField.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        holdMoneyLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func saveCredits() {
        guard let cardNumber = cardNumber, let period = period, let cvc = cvc else { return }
        
        let cardModel = CardModel(num: cardNumber, period: period, cvc: cvc) //validate credits
        
        router?.dataStore?.order?.card = cardModel
     
        if let order = router?.dataStore?.order {
            router?.routeToPaymentConfirmation(model: order)
        }
    }
}

// MARK: - MainTextFieldDelegate
extension LinkNewCardViewController: MainTextFieldDelegate {
    func getTextField(text: String, type: ViewType) {
        switch type {
        case .cardNumber:
            cardNumber = text
        case .validityPeriod:
            period = text
        case .cvc:
            cvc = text
        default:
            break
        }
    }
}
