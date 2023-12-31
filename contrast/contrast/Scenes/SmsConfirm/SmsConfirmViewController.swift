//
//  SmsConfirmViewController.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SmsConfirmDisplayLogic: AnyObject {
    func display(viewModel: SmsConfirm.Model.ViewModel.ViewModelType)
}

final class SmsConfirmViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.enterCode()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalMedium34
        return label
    }()
    
    private let otpStackView = OTPStackView()
    
    private let repeatedCodeButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitleColor(R.color.textLight(), for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let confirmButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        button.isEnabledButton = false
        return button
    }()
    
    private let wrongCodeLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.wrongCode()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular11
        label.isHidden = true
        return label
    }()
    
    // MARK: - External vars
    var interactor: SmsConfirmBusinessLogic?
    var router: (NSObjectProtocol & SmsConfirmRoutingLogic & SmsConfirmDataPassing)?
    private let analytics = AnalyticsService.shared
    
    // MARK: - Internal vars
    private var timer: Timer?
    private var remainingSeconds = 0
    private var secondsNumber = 0
    private var hasError = false {
        didSet {
            confirmButton.isEnabledButton = false
            wrongCodeLabel.isHidden = !hasError
            otpStackView.hasError = hasError
        }
    }
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SmsConfirmConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SmsConfirmConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Display logic
extension SmsConfirmViewController: SmsConfirmDisplayLogic {
    
    func display(viewModel: SmsConfirm.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .verifyResponse(let firstRegister):
            if firstRegister {
                router?.routeToReferal()
            } else {
                router?.routeToLoginParams()
            }
        case .failureUserAuth:
            hasError = true
        case .successSend(let viewModel):
            remainingSeconds = viewModel.timer ?? 0
            setupTimer()
        }
    }
}

// MARK: - Private methods
private extension SmsConfirmViewController {
    private func setupView() {
        view.backgroundColor = R.color.mainBackgroundColor()
        repeatedCodeButton.addTarget(self, action: #selector(getNewCode), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmCode), for: .touchUpInside)
        otpStackView.delegate = self
        setupConstraints()
        
        guard router?.dataStore?.verifyType == 0 else {
            repeatedCodeButton.isHidden = true
            return
        }
        
        secondsNumber = router?.dataStore?.timer ?? 0
        remainingSeconds = router?.dataStore?.timer ?? 0
        updateButtonTitle()
        setupTimer()
        analytics.routeTo(screen: .verify)
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(otpStackView)
        view.addSubview(repeatedCodeButton)
        view.addSubview(confirmButton)
        view.addSubview(wrongCodeLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(87)
            $0.height.equalTo(41)
        }
        
        otpStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(244)
            $0.height.equalTo(52)
        }
        
        wrongCodeLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(otpStackView.snp.bottom).offset(6)
        }
        
        repeatedCodeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(wrongCodeLabel.snp.bottom).offset(11)
            $0.height.equalTo(46)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(repeatedCodeButton.snp.bottom).offset(22)
            $0.height.equalTo(46)
        }
    }
    
    private func setupTimer() {
        repeatedCodeButton.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateButtonTitle), userInfo: nil, repeats: true)
    }
    
    @objc private func updateButtonTitle() {
        remainingSeconds -= 1
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        let countdownText = String(format: "%d:%02d", minutes, seconds)
        
        repeatedCodeButton.setTitle(R.string.localizable.recendCodeVia(countdownText), for: .normal)
            
        if remainingSeconds == 0 {
            stopCountdown()
        }
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        repeatedCodeButton.isUserInteractionEnabled = true
        repeatedCodeButton.setTitle(R.string.localizable.recendCodeAgain(), for: .normal)
    }
    
    @objc private func getNewCode() {
        interactor?.make(request: .sendSms)
    }
    
    @objc private func confirmCode() {
        interactor?.make(request: .verify(otpStackView.getOTP()))
    }
}

// MARK: - Public methods
extension SmsConfirmViewController: OTPDelegateProtocol {
    func didChangeValidity(isValid: Bool) {
        confirmButton.isEnabledButton = isValid
    }
    
    func hideError() {
        if hasError {
            hasError = false
        }
    }
}


