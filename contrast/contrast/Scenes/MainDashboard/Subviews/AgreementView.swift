//
//  AgreementView.swift
//  contrast
//
//  Created by Александра Орлова on 12.07.2023.
//

import Foundation
import UIKit

protocol AgreementViewDelegate: AnyObject {
    func rejectTapped()
    func payTapped()
}

final class AgreementView: UIView {
    
    private let hasQuestionslabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = UIColor.textDark2
        label.text = R.string.localizable.hasQuestions()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let rejectButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.reject(), for: .normal)
        return button
    }()
    
    private let payButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.pay(), for: .normal)
        return button
    }()
    
    private let descriptionlabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular12
        label.textColor = UIColor.textLight
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Lorem Ipsum - это текст-рыба, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной рыбой для текстов на латинице с начала XVI века.";
        return label
    }()
    
    weak var delegate: AgreementViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension AgreementView {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(hasQuestionslabel)
        addSubview(rejectButton)
        addSubview(payButton)
        addSubview(descriptionlabel)
        
        setupConstraints()
        rejectButton.addTarget(self, action: #selector(rejectTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        hasQuestionslabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview()
        }
        
        rejectButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(hasQuestionslabel.snp.trailing).offset(10)
            $0.height.equalTo(37)
            $0.width.equalTo(90)
        }
        
        payButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(rejectButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(37)
            $0.width.equalTo(90)
        }
        
        descriptionlabel.snp.makeConstraints {
            $0.top.equalTo(rejectButton.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func rejectTapped() {
        delegate?.rejectTapped()
    }
    
    @objc private func payTapped() {
        delegate?.payTapped()
    }
}
