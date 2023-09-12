//
//  UIViewController.swift
//  contrast
//
//  Created by Roman Kiruxin on 03.07.2023.
//

import UIKit

extension UIViewController {
    
    enum NavigationBarType {
        case titleOnly
        case titleAndBackIcon
        case backIconOnly
    }
    
    func setupDissmisKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func setupNavBar(withTitle title: String? = nil, type: NavigationBarType = .titleAndBackIcon, dismiss: Bool = false) {
        navigationController?.isNavigationBarHidden = false
        
        switch type {
        case .titleOnly:
            setupNavigationBarWith(title: title, backButtonImage: nil, dismiss: dismiss)
        case .titleAndBackIcon:
            setupNavigationBarWith(title: title, backButtonImage: R.image.arrowBack(), dismiss: dismiss)
        case .backIconOnly:
            setupNavigationBarWith(title: nil, backButtonImage: R.image.arrowBack(), dismiss: dismiss)
        }
    }
    
    private func setupNavigationBarWith(title: String? = nil, backButtonImage: UIImage? = R.image.arrowBack(), dismiss: Bool) {
        if let backButtonImage = backButtonImage {
            setupLeftBarButtonItem(dismiss: dismiss)
        }
        
        if let title = title {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.textColor = R.color.textDark()
            titleLabel.font = GeneralFonts.generalRegular17
            navigationItem.titleView = titleLabel
        } else {
            navigationItem.titleView = nil
        }
    }
    
    private func setupLeftBarButtonItem(dismiss: Bool) {
        if dismiss {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.arrowBack(),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(screenDismiss))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.arrowBack(),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(navigateBack))
        }
        navigationItem.leftBarButtonItem?.tintColor = R.color.backButtonColor()
    }
        
    func setupNavBar(withTitle title: String, and description: String, dismiss: Bool, rightButton: UIBarButtonItem? = nil) {
        
        navigationController?.isNavigationBarHidden = false
        setupLeftBarButtonItem(dismiss: dismiss)
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = R.color.backButtonColor()
        
        let view = UIView()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = GeneralFonts.generalRegular10
            label.textColor = .textLight
            label.text = title
            return label
        }()
        
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = GeneralFonts.generalRegular17
            label.textColor = .textDark
            label.text = description
            return label
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview()
        }
        
        navigationItem.titleView = view
    }
    
    @objc private func navigateBack() {
        navigationController?.popViewController(animated: true)
        
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func screenDismiss() {
        dismiss(animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showAlertError(title:String) {
        let alert = UIAlertController(title: "Ошибка", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
            case .destructive:
                print("cancel")
            @unknown default:
                print("cancel")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
