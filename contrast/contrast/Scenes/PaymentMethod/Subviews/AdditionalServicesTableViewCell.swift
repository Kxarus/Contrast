//
//  AdditionalServicesTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//

import UIKit

protocol AdditionalServicesDelegate: AnyObject {
    func addService(sum: Float, serviceNumber: Int, serviceState: Bool)
}

final class AdditionalServicesTableViewCell: UITableViewCell, Reusable {
    
    private let serviceImageView: UIImageView = {
        let imageView = UIImageView(image: R.image.discountImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textDark()
        label.font = GeneralFonts.generalRegular15
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textLight()
        label.font = GeneralFonts.generalRegular11
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusIcon(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var addButtonIsActive = false {
        didSet {
            addButton.setImage(addButtonIsActive ? R.image.checkMarkIcon() : R.image.plusIcon(), for: .normal)
        }
    }
    
    weak var delegate: AdditionalServicesDelegate?
    
    // MARK: - Internal vars
    private var serviceSum: Float = 0.0
    private var serviceNumber = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension AdditionalServicesTableViewCell {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        contentView.isUserInteractionEnabled = true
        addSubview(serviceImageView)
        addSubview(titleLabel)
        addSubview(sumLabel)
        addSubview(descriptionLabel)
        addSubview(addButton)
        setupConstraints()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        serviceImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalToSuperview().offset(22)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(serviceImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(serviceImageView.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        sumLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalTo(addButton.snp.leading).offset(-12)
            $0.height.equalTo(25)
        }
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(15)
        }
    }
    
    @objc private func addButtonTapped() {
        addButtonIsActive.toggle()
        delegate?.addService(sum: addButtonIsActive ? serviceSum : -serviceSum, serviceNumber: serviceNumber, serviceState: addButtonIsActive)
    }
}

// MARK: - Public methods
extension AdditionalServicesTableViewCell {
    func setupCell(model: AdditionalService, number: Int) {
        serviceNumber = number
        addButtonIsActive = model.isSelected
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        serviceSum = model.sum
        sumLabel.text = R.string.localizable.finalSum(model.sum.formattedString)
    }
}

