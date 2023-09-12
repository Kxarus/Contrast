//
//  OnBoardingFourthViewController.swift
//  contrast
//
//  Created by Roman Kiruxin on 30.06.2023.
//

import UIKit

protocol OnBoardingFourthViewControllerDelegate: AnyObject {
    func routeToPincode()
    func routeToLogin()
}

final class OnBoardingFourthViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium29
        label.textColor = .textDark
        label.text = R.string.localizable.onboardingFourthTitle()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .textTone
        label.text = "это текст-рыба, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной рыбой для текстов на латинице с начала XVI века."
        return label
    }()

    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = R.image.fourthOnBoarding()
        return imageview
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.setTitle(R.string.localizable.onboardingFourthMainButtonTitle(), for: .normal)
        return button
    }()
    
    private let additionalButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .emptyFill)
        button.setTitle(R.string.localizable.skip(), for: .normal)
        return button
    }()
    
    weak var delegate: OnBoardingFourthViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Private methods
private extension OnBoardingFourthViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        view.addSubview(mainButton)
        view.addSubview(additionalButton)
        
        mainButton.addTarget(self, action: #selector(pressMainButton), for: .touchUpInside)
        additionalButton.addTarget(self, action: #selector(pressAdditionalButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().inset(61)
            $0.width.equalTo(223)
            $0.height.equalTo(185)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.top).offset(-43)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-14)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        mainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        
        additionalButton.snp.makeConstraints {
            $0.bottom.equalTo(mainButton.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func pressMainButton() {
        delegate?.routeToLogin()
    }
    
    @objc private func pressAdditionalButton() {
        delegate?.routeToPincode()
    }
}

// MARK: - Public methods
extension OnBoardingFourthViewController {
    
}
