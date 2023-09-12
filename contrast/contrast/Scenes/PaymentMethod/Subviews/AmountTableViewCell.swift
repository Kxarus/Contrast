//
//  AmountTableViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 05.07.2023.
//

import UIKit

protocol PointsTextFieldDelegate: AnyObject {
    func getPoints(number: Int)
}

final class AmountTableViewCell: UITableViewCell, Reusable {
    
    private let container: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.borderLight.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .textDark
        textField.font = GeneralFonts.generalRegular15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalRegular11
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.pointsPayment()
        return label
    }()
    
    private let maxPointsLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.font = GeneralFonts.generalRegular15
        label.textAlignment = .center
        label.textColor = R.color.textDark2()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxPointsView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundLight
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let sumWithoutPointsLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular12
        label.textAlignment = .left
        label.textColor = R.color.textLight()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let finalSumLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalMedium32
        label.textAlignment = .left
        label.textColor = R.color.textDark()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let additionalPointsLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular15
        label.textAlignment = .right
        label.textColor = R.color.textDark()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var maxPointsNumber = 0
    private var usedPointsNumber = 0
    
    weak var delegate: PointsTextFieldDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
extension AmountTableViewCell {
    private func setup() {
        backgroundColor = UIColor.mainBackgroundColor
        contentView.backgroundColor = UIColor.mainBackgroundColor
        addSubview(container)
        addSubview(sumWithoutPointsLabel)
        addSubview(finalSumLabel)
        addSubview(additionalPointsLabel)
        container.addSubview(inputTextField)
        container.addSubview(titleLabel)
        container.addSubview(maxPointsView)
        maxPointsView.addSubview(maxPointsLabel)
        inputTextField.keyboardType = .numberPad
        inputTextField.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        container.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(39)
            $0.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(85)
        }
        
        maxPointsView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(37)
        }
        
        maxPointsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.top.equalToSuperview().offset(12)
            $0.height.equalTo(11)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(maxPointsView.snp.leading).offset(-16)
            $0.height.equalTo(20)
        }
        
        sumWithoutPointsLabel.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(27)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(additionalPointsLabel.snp.leading).offset(-5)
        }
        
        finalSumLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(sumWithoutPointsLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(additionalPointsLabel.snp.leading).offset(-10)
            $0.bottom.equalToSuperview()
        }
        
        additionalPointsLabel.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(27)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(20)
        }
    }
}

// MARK: - Public methods
extension AmountTableViewCell {
    func setupCell(model: PaymentMethodModel, points: Int) {
        maxPointsNumber = model.maxPointsNumber
        inputTextField.text = String(points)
        maxPointsLabel.text = R.string.localizable.pointsMax(String(model.maxPointsNumber))
        sumWithoutPointsLabel.text = R.string.localizable.sumWithoutPoints(model.sumWithoutPoints.formattedString)
        
        let pointsBack = model.finalSum * Float(model.pointsBackPercent) / 100.0
        finalSumLabel.text = R.string.localizable.finalSum(model.finalSum.formattedString)
        additionalPointsLabel.text = R.string.localizable.plusPoints(String(Int(pointsBack)))
    }
}

// MARK: - UITextFieldDelegate
extension AmountTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
                
        if let pointsNumber = Int(updatedText) {
            if pointsNumber > maxPointsNumber {
                return false
            }
            
            usedPointsNumber = pointsNumber
        } else {
            usedPointsNumber = 0
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.text = "0"
        }
        
        delegate?.getPoints(number: usedPointsNumber)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "0" {
            textField.text = ""
        }
    }
}

