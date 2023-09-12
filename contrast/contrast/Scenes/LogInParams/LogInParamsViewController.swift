//
//  LogInParamsViewController.swift
//  contrast
//
//  Created by Александра Орлова on 29.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

protocol LogInParamsDisplayLogic: AnyObject {
    func display(viewModel: LogInParams.Model.ViewModel.ViewModelType)
}

final class LogInParamsViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.logInApp()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalMedium34
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.securityMessage()
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalRegular15
        label.numberOfLines = 0
        return label
    }()
    
    private let securityImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.securityImage())
        return imageView
    }()
    
    private let skipButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .emptyFill)
        button.setTitle(R.string.localizable.skip(), for: .normal)
        return button
    }()
    
    private let pincodeButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.pincodeLogin(), for: .normal)
        return button
    }()
    
    // MARK: - External vars
    var interactor: LogInParamsBusinessLogic?
    var router: (NSObjectProtocol & LogInParamsRoutingLogic & LogInParamsDataPassing)?
    
    // MARK: - Internal vars
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        LogInParamsConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LogInParamsConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        UserDefaultsWorker.saveOfferEnterCode(true)
    }
}

// MARK: - Display logic
extension LogInParamsViewController: LogInParamsDisplayLogic {
    
    func display(viewModel: LogInParams.Model.ViewModel.ViewModelType) {
        switch viewModel {
            
        }
    }
}

// MARK: - Private methods
private extension LogInParamsViewController {
    private func setupView() {
        view.backgroundColor = R.color.mainBackgroundColor()
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        pincodeButton.addTarget(self, action: #selector(pincodeTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(securityImageView)
        view.addSubview(skipButton)
        view.addSubview(pincodeButton)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(87)
            $0.height.equalTo(41)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        
        securityImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.medium)
            $0.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(35).priority(.high)
            $0.height.equalTo(186)
            $0.width.equalTo(205)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(pincodeButton.snp.top).offset(-10)
            $0.height.equalTo(46)
        }
        
        pincodeButton.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-35)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func skipTapped() {
        router?.routeToMain()
    }
    
    @objc private func pincodeTapped() {
        router?.routeToPincode()
    }
}

// MARK: - Public methods
extension LogInParamsViewController {
    
}

