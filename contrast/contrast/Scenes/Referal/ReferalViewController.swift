//
//  ReferalViewController.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

protocol ReferalDisplayLogic: AnyObject {
    func display(viewModel: Referal.Model.ViewModel.ViewModelType)
}

final class ReferalViewController: UIViewController {
    
    // MARK: - IBOutlets
    private lazy var referalView: MainTextField = {
        let view = MainTextField()
        view.setupView(typeView: .referal, codeText: R.string.localizable.invitationCode(), placeHolder: R.string.localizable.code())
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.invitationCode()
        label.numberOfLines = 0
        label.font = GeneralFonts.generalMedium34
        label.textColor = .textDark
        return label
    }()
    
    private let skipButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.skip(), for: .normal)
        button.setupStyle(style: .emptyFill)
        return button
    }()
    
    private let confirmButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        button.isEnabledButton = false
        button.setupStyle(style: .fill)
        return button
    }()
    
    // MARK: - External vars
    var interactor: ReferalBusinessLogic?
    var router: (NSObjectProtocol & ReferalRoutingLogic & ReferalDataPassing)?
    
    // MARK: - Internal vars
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        ReferalConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ReferalConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension ReferalViewController: ReferalDisplayLogic {
    
    func display(viewModel: Referal.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .referalCodeStatus(let status):
            if status {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.referalView.stopAnimation()
                    self?.referalView.showView(image: R.image.access()!,
                                               text: R.string.localizable.getPoints())
                    self?.confirmButton.isEnabledButton = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.referalView.stopAnimation()
                    self?.referalView.showView(image: R.image.fail()!,
                                               text: R.string.localizable.codeNotCorrectly())
                    self?.confirmButton.isEnabledButton = false
                }
            }
        }
    }
}

// MARK: - Private methods
private extension ReferalViewController {
    
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(referalView)
        view.addSubview(skipButton)
        view.addSubview(confirmButton)
        
        referalView.delegate = self
        skipButton.addTarget(self, action: #selector(routeToPincodeSet), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(routeToPincodeSet), for: .touchUpInside)
        setupDissmisKeyboard()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(referalView.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        referalView.snp.makeConstraints ({
            $0.bottom.equalTo(skipButton.snp.top).offset(-18)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        })
        
        skipButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(skipButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func routeToPincodeSet() {
        self.router?.routeToLogInParams()
    }
}

// MARK: - PromoCodeViewDelegate
extension ReferalViewController: MainTextFieldDelegate {
    func getTextField(text: String, type: ViewType) {
        interactor?.make(request: .postInvitedCode(text))
    }
}





