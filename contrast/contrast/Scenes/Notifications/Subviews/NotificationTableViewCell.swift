//
//  NotificationTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//

import UIKit

final class NotificationTableViewCell: UITableViewCell, Reusable {
    
    private let container: ShadowView = {
        let view = ShadowView()
        view.setupView(borderColor: UIColor.borderCard)
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = R.color.textDark()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular11
        label.textAlignment = .left
        label.textColor = R.color.textLight()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .emptyFill)
        button.titleLabel?.font = GeneralFonts.generalRegular13
        button.setTitle(R.string.localizable.question(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let acceptButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.titleLabel?.font = GeneralFonts.generalRegular13
        button.setTitle(R.string.localizable.accept(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension NotificationTableViewCell {
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = R.color.mainBackgroundColor()
        addSubview(container)
        
        container.addSubview(messageLabel)
        container.addSubview(timeLabel)
    }
    
    private func setupConstraints(showButtons: Bool) {
        if showButtons {
            container.addSubview(questionButton)
            container.addSubview(acceptButton)
            
            acceptButton.snp.makeConstraints {
                $0.top.equalTo(timeLabel.snp.bottom).offset(8)
                $0.trailing.equalToSuperview().offset(-17)
                $0.bottom.equalToSuperview().offset(-16)
                $0.width.equalTo(89)
                $0.height.equalTo(37)
            }
            
            questionButton.snp.makeConstraints {
                $0.top.equalTo(timeLabel.snp.bottom).offset(8)
                $0.trailing.equalTo(acceptButton.snp.leading).offset(-8)
                $0.bottom.equalToSuperview().offset(-16)
                $0.width.equalTo(89)
                $0.height.equalTo(37)
            }
        }
        
        container.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(17)
            $0.width.equalTo(28)
            $0.height.equalTo(22)
            if !showButtons {
                $0.bottom.equalToSuperview().offset(-16)
            }
        }
    }
}

// MARK: - Public methods
extension NotificationTableViewCell {
    func setupCell(model: NotificationItem) {
        messageLabel.text = model.message
        timeLabel.text = model.time
        
        setupConstraints(showButtons: model.hasQuestion)
    }
}
