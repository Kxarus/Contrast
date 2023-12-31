//
//  PromoCodeViewController.swift
//  contrast
//
//  Created by Владимир on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

protocol PromoCodeDisplayLogic: AnyObject {
    func display(viewModel: PromoCode.Model.ViewModel.ViewModelType)
}

final class PromoCodeViewController: UIViewController {
    
    // MARK: - IBOutlets
    private lazy var promoСodeView: PromocodeView = {
        let view = PromocodeView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.invitationCode()
        label.numberOfLines = 0
        label.font = GeneralFonts.generalMedium34
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = GeneralFonts.generalRegular11
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
    var interactor: PromoCodeBusinessLogic?
    var router: (NSObjectProtocol & PromoCodeRoutingLogic & PromoCodeDataPassing)?
    
    // MARK: - Internal vars
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        PromoCodeConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        PromoCodeConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension PromoCodeViewController: PromoCodeDisplayLogic {
    
    func display(viewModel: PromoCode.Model.ViewModel.ViewModelType) {
        switch viewModel {
        case .promoCodeStatus(let status):
            if status {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.promoСodeView.stopAnimation()
                    self?.promoСodeView.showImage(image: R.image.access()!)
                    self?.infoLabel.text = R.string.localizable.getPoints()
                    self?.promoСodeView.hideImage()
                    self?.confirmButton.isEnabledButton = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.promoСodeView.stopAnimation()
                    self?.infoLabel.text = R.string.localizable.codeNotCorrectly()
                    self?.promoСodeView.showImage(image: R.image.fail()!)
                    self?.promoСodeView.hideImage()
                    self?.confirmButton.isEnabledButton = false
                }
            }
        }
    }
}

//MARK: - Keyboard Logic
private extension PromoCodeViewController {
    
   private func observingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        if UIScreen.main.bounds.height == 568 {
            // Изменения для iPhone SE 1-го поколения
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(5)
                $0.left.equalToSuperview().offset(16)
                $0.right.equalToSuperview().offset(-16)
                $0.width.equalTo(375)
                $0.height.equalTo(129)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        
        if UIScreen.main.bounds.height == 568 {
            // Изменения для iPhone SE 1-го поколения
            titleLabel.snp.makeConstraints {
                titleLabel.snp.removeConstraints()
                $0.top.equalToSuperview().offset(66)
                $0.left.equalToSuperview().offset(16)
                $0.right.equalToSuperview().offset(-16)
                $0.width.equalTo(375)
                $0.height.equalTo(129)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }

    }
}

// MARK: - Private methods
private extension PromoCodeViewController {
    
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(promoСodeView)
        view.addSubview(infoLabel)
        view.addSubview(skipButton)
        view.addSubview(confirmButton)
        view.backgroundColor = .white
        promoСodeView.delegate = self
        skipButton.addTarget(self, action: #selector(skipPromo), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(routeToLogin), for: .touchUpInside)
        
        setupDissmisKeyboard()
        observingKeyboard()
        setupConstraints()
    }
    @objc
    private func skipPromo() {
        self.router?.routeToLogInParams()
    }
    @objc
    private func routeToLogin() {
        self.router?.routeToLogInParams()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(66)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(375)
            $0.height.equalTo(129)
        }
        
        promoСodeView.snp.makeConstraints ({
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view).inset(16)
            $0.height.equalTo(50)
        })
        
        skipButton.snp.makeConstraints {
            $0.top.equalTo(promoСodeView.snp.bottom).offset(18)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.width.equalTo(46)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(skipButton.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(46)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(promoСodeView.snp.bottom).offset(2)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(13)
        }
    }
}

// MARK: - PromoCodeViewDelegate
extension PromoCodeViewController: PromoCodeViewDelegate {
    func verifyingPromoCode(code: String) {
        interactor?.make(request: .postInvitedCode(code))
    }
    
    func updateInfoLabelVisibility(_ isVisible: Bool) {
        infoLabel.isHidden = !isVisible
    }
}






