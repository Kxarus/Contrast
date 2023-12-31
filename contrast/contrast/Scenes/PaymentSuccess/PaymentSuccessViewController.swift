//
//  PaymentSuccessViewController.swift
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

protocol PaymentSuccessDisplayLogic: AnyObject {
    func display(viewModel: PaymentSuccess.Model.ViewModel.ViewModelType)
}

final class PaymentSuccessViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular17
        label.text = R.string.localizable.paymentSuccess()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textLight()
        label.font = GeneralFonts.generalRegular15
        label.text = R.string.localizable.paymentSuccessSubtitle()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.toMain(), for: .normal)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.paymentSuccess())
        return imageView
    }()
    
    // MARK: - External vars
    var interactor: PaymentSuccessBusinessLogic?
    var router: (NSObjectProtocol & PaymentSuccessRoutingLogic & PaymentSuccessDataPassing)?
    
    // MARK: - Internal vars
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        PaymentSuccessConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PaymentSuccessConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Display logic
extension PaymentSuccessViewController: PaymentSuccessDisplayLogic {
    
    func display(viewModel: PaymentSuccess.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension PaymentSuccessViewController {
    private func setupView() {
        view.backgroundColor = UIColor.mainBackgroundColor
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(mainButton)
        view.addSubview(imageView)
        
        setupConstraints()
        mainButton.addTarget(self, action: #selector(mainTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.width.equalTo(265)
            $0.height.equalTo(254)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(61)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(13)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(50)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        mainButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func mainTapped() {
        router?.routeToMain()
    }
}

// MARK: - Public methods
extension PaymentSuccessViewController {
    
}


