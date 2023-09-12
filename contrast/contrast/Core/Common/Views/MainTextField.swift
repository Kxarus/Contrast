//
//  UIView.swift
//  contrast
//
//  Created by Владимир on 04.07.2023.
//

import Foundation
import UIKit
import SnapKit

protocol MainTextFieldDelegate: AnyObject {
    func getTextField(text: String, type: ViewType)
}

enum ViewType {
    case referal
    case another
    case cardNumber
    case validityPeriod
    case cvc
    
    case cityStreet
    case entry
    case flat
    case floor
    case intercom
    case commentForCourier

    case promocodeOrder
}

final class MainTextField: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.3)
        view.layer.shadowRadius = 0.5
        return view
    }()
    
    private let imageStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalRegular11
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textTone()
        label.font = GeneralFonts.generalRegular11
        label.isHidden = true
        return label
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .textDark
        textField.font = GeneralFonts.generalRegular15
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.setImage(R.image.clearTextIcon(), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private var isAnimatingActivityIndicator: Bool = false
    private var previousInputCount: Int = 0
    private var viewType: ViewType?
    weak var delegate: MainTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: bounds.height - 5, width: bounds.width, height: 2))
        containerView.layer.shadowPath = shadowPath.cgPath
    }
}

// MARK: - UITextFieldDelegate
extension MainTextField: UITextFieldDelegate {
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let currentInputCount = textField.text?.count ?? 0
        switch viewType {
        case .promocodeOrder:
            displayTitle()
            delegate?.getTextField(text: textField.text!, type: (viewType)!)
            if currentInputCount == previousInputCount - 1 {
                imageStatus.isHidden = true
                infoLabel.isHidden = true
            }
        case .referal:
            if inputTextField.text?.count == 8 {
                textField.resignFirstResponder()
                activityIndicator.startAnimating()
                delegate?.getTextField(text: textField.text!, type: .referal)
                imageStatus.isHidden = true
                infoLabel.isHidden = false
                clearButton.isHidden = true
            } else if inputTextField.text?.count ?? 0 > 8 {
                inputTextField.text = String(inputTextField.text?.prefix(8) ?? "")
            } else {
                displayTitle()
                activityIndicator.stopAnimating()
                imageStatus.isHidden = true
                infoLabel.isHidden = true
            }
        case .cardNumber, .validityPeriod, .cvc:
            clearButton.isHidden = true
        case .entry, .flat, .floor, .intercom, .commentForCourier:
            clearButton.isHidden = true
            displayTitle()
            delegate?.getTextField(text: textField.text!, type: viewType!)
        default:
            displayTitle()
            clearButton.isHidden = false
            delegate?.getTextField(text: textField.text!, type: .another)
        }
        previousInputCount = currentInputCount
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch viewType {
        case .cardNumber:
            inputTextField.addCardNumberMask(in: range, replacementString: string)
        case .validityPeriod:
            inputTextField.addValidityPeriodMask(in: range, replacementString: string)
        case .cvc:
            inputTextField.addCVCMask(in: range, replacementString: string)
        case .referal,
                .another,
                .entry,
                .flat,
                .floor,
                .intercom,
                .commentForCourier:
            return true
        case .referal, .promocodeOrder, .another:
            return true
        default:
            break
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = true
        delegate?.getTextField(text: textField.text! , type: viewType ?? .another)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if inputTextField.text?.isEmpty == false && viewType == .another {
            clearButton.isHidden = false
        }
    }
}

// MARK: - Private methods
private extension MainTextField {
    
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(inputTextField)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageStatus)
        containerView.addSubview(infoLabel)
        containerView.addSubview(clearButton)
        
        setupConstrains()
        addTapGesture()
        configureText()
    }
    
    private func displayTitle() {
        if inputTextField.text?.isEmpty == false {
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
    }
    
    private func configureText() {
        inputTextField.delegate = self
        inputTextField.keyboardType = .default
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstrains() {
        clearButton.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.centerY.equalTo(containerView)
            $0.right.equalTo(containerView).offset(-10)
        }
        
        containerView.snp.makeConstraints({
            $0.edges.equalTo(self)
        })
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(containerView.snp.top).offset(16)
            $0.left.equalTo(containerView).offset(16)
            $0.right.equalTo(containerView)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(2)
            $0.right.equalToSuperview().offset(-2)
        }
        
        inputTextField.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.left.equalTo(containerView).offset(16)
            $0.right.equalTo(activityIndicator).offset(-25)
            $0.height.equalTo(20)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.right.equalTo(containerView).offset(-10)
            $0.height.equalTo(inputTextField)
        }
        
        imageStatus.snp.makeConstraints {
            $0.centerY.equalTo(containerView)
            $0.right.equalTo(containerView).offset(-10)
            $0.height.equalTo(inputTextField)
        }
    }
    
    @objc private func handleTapGesture() {
        inputTextField.becomeFirstResponder()
    }
    
    @objc private func clearButtonTapped() {
        inputTextField.text = ""
        titleLabel.isHidden = true
    }
}
// MARK: - Public methods
extension MainTextField {
    
    func setupView(typeView: ViewType?, codeText: String?, placeHolder: String?) {
        titleLabel.text = codeText
        inputTextField.placeholder = placeHolder
        viewType = typeView
        
        switch typeView {
        case .cvc, .cardNumber, .validityPeriod:
            titleLabel.isHidden = false
            inputTextField.keyboardType = .numberPad
        case .entry, .flat, .floor:
            inputTextField.snp.remakeConstraints {
                $0.centerY.equalTo(containerView)
                $0.left.equalTo(containerView).offset(16)
                $0.right.equalTo(containerView)
                $0.height.equalTo(20)
            }
            inputTextField.keyboardType = .numberPad
        case .intercom:
            inputTextField.keyboardType = .numberPad
        case .promocodeOrder:
            titleLabel.isHidden = true
            inputTextField.keyboardType = .default
            inputTextField.placeholder = codeText
            infoLabel.isHidden = false
        default:
            break
        }
    }
    
    func stopAnimation() {
        self.activityIndicator.stopAnimating()
    }
    
    func toggleAnimation() {
        isAnimatingActivityIndicator = !isAnimatingActivityIndicator
        if isAnimatingActivityIndicator {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showView(image: UIImage, text: String) {
        imageStatus.isHidden = false
        imageStatus.image = image
        infoLabel.text = text
        
    }
    
    func setText(text: String) {
        inputTextField.text = text
        displayTitle()
    }
}
