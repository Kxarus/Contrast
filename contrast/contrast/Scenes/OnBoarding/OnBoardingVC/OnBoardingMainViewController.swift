//
//  OnBoardingMainViewController.swift
//  contrast
//
//  Created by Roman Kiruxin on 30.06.2023.
//

import UIKit

protocol OnBoardingEvents: AnyObject {
    func pressMainButton()
    func pressAdditionalButton()
}

final class OnBoardingMainViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium17
        label.textAlignment = .center
        label.textColor = .textDark
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .textTone
        return label
    }()
    
    private let mainButton: MainButton = {
        let button = MainButton()
        return button
    }()
    
    private let additionalButton: MainButton = {
        let button = MainButton()
        button.isHidden = true
        button.setupStyle(style: .emptyFill)
        button.setTitle(R.string.localizable.next(), for: .normal)
        return button
    }()
    
    weak var delegate: OnBoardingEvents?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private methods
private extension OnBoardingMainViewController {
    private func setup() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(mainButton)
        view.addSubview(additionalButton)
        
        mainButton.addTarget(self, action: #selector(pressMainButton), for: .touchUpInside)
        additionalButton.addTarget(self, action: #selector(pressAdditionalButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-114)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(228)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(47)
            $0.leading.trailing.equalToSuperview().inset(31)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
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
        delegate?.pressMainButton()
    }
    
    @objc private func pressAdditionalButton() {
        delegate?.pressAdditionalButton()
    }
}

// MARK: - Public methods
extension OnBoardingMainViewController {
    func setupView(image: UIImage, title: String, description: String, titleMainButton: String, isAdditionalButtonHidden: Bool) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
        mainButton.setTitle(titleMainButton, for: .normal)
        additionalButton.isHidden = isAdditionalButtonHidden
    }
}

