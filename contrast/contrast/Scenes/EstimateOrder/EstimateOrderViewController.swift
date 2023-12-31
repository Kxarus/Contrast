//
//  EstimateOrderViewController.swift
//  contrast
//
//  Created by Александра Орлова on 04.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PanModal

protocol EstimateOrderDisplayLogic: AnyObject {
    func display(viewModel: EstimateOrder.Model.ViewModel.ViewModelType)
}

final class EstimateOrderViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let dragView: UIView = {
        let view = UIView()
        view.backgroundColor = .textLight
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let starsStack = StarsStackView()
    
    private let loadPhotoButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.loadPhoto(), for: .normal)
        return button
    }()
    
    private let photosCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.mainBackgroundColor
        return collectionView
    }()
    
    private let confirmButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .fill)
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        button.isEnabledButton = false
        return button
    }()
    
    private let cancelButton: MainButton = {
        let button = MainButton()
        button.setupStyle(style: .border())
        button.setTitle(R.string.localizable.cancel(), for: .normal)
        return button
    }()
    
    private let photoFormatLabel: UILabel = {
        let label = UILabel()
        label.font = GeneralFonts.generalRegular13
        label.textColor = UIColor.textLight
        label.textAlignment = .center
        label.text = R.string.localizable.photoFormat()
        return label
    }()
    
    private let commentTextField: MainTextField = {
        let view = MainTextField()
        view.setupView(typeView: .another, codeText: R.string.localizable.yourComment(), placeHolder: R.string.localizable.yourComment())
        return view
    }()
    
    // MARK: - External vars
    var interactor: EstimateOrderBusinessLogic?
    var router: (NSObjectProtocol & EstimateOrderRoutingLogic & EstimateOrderDataPassing)?
    var panScrollable: UIScrollView?
    
    // MARK: - Internal vars
    private var images = [UIImage]()
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        EstimateOrderConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        EstimateOrderConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Display logic
extension EstimateOrderViewController: EstimateOrderDisplayLogic {
    
    func display(viewModel: EstimateOrder.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension EstimateOrderViewController {
    private func setupView() {
        setupDissmisKeyboard()
        view.backgroundColor = UIColor.mainBackgroundColor
        view.addSubview(dragView)
        view.addSubview(starsStack)
        view.addSubview(photoFormatLabel)
        view.addSubview(loadPhotoButton)
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        view.addSubview(photosCollectionView)
        view.addSubview(commentTextField)
        setupConstraints()
        setupCollectionview()
        
        starsStack.delegate = self
        
        loadPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }
    
    private func setupCollectionview() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(cellTypes: [PhotoCollectionViewCell.self])
    }
    
    private func setupConstraints() {
        dragView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(5)
        }
        
        starsStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(47)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(288)
        }
        
        commentTextField.snp.makeConstraints {
            $0.top.equalTo(starsStack.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        
        photosCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(commentTextField.snp.bottom).offset(20)
            $0.height.equalTo(120)
        }
        
        photoFormatLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(loadPhotoButton.snp.top).offset(-10)
            $0.height.equalTo(18)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-25)
            $0.height.equalTo(46)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-10)
            $0.height.equalTo(46)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        loadPhotoButton.snp.makeConstraints {
            $0.bottom.equalTo(cancelButton.snp.top).offset(-10)
            $0.height.equalTo(46)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc private func cancelTapped() {
        router?.routeToMain()
    }
    
    @objc private func confirmTapped() {
        router?.routeToMain()
    }
    
    @objc private func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: R.string.localizable.choosePhoto(),
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: R.string.localizable.photo(),
                                            style: .default,
                                            handler: { [weak self] _ in
            imagePickerController.sourceType = .camera
            self?.present(imagePickerController,
                         animated: true,
                         completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: R.string.localizable.photoLibrary(),
                                            style: .default,
                                            handler: { [weak self] _ in
            imagePickerController.sourceType = .photoLibrary
            self?.present(imagePickerController,
                         animated: true,
                         completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: R.string.localizable.cancelation(),
                                            style: .cancel,
                                            handler: nil))
        self.present(actionSheet,
                     animated: true,
                     completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension EstimateOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: PhotoCollectionViewCell.self, for: indexPath)
        cell.setupCellWithPhoto(image: images[indexPath.row], photoNumber: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EstimateOrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}


// MARK: - UIImagePickerControllerDelegate
extension EstimateOrderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            images.append(image)
            photosCollectionView.reloadData()
        } else {
            print("Something went wrong")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - PhotoCollectionViewCellDelegate
extension EstimateOrderViewController: PhotoCollectionViewCellDelegate {
    func deletePhoto(photoNumber: Int) {
        images.remove(at: photoNumber)
        photosCollectionView.reloadData()
    }
}

// MARK: - MainTextFieldDelegate
extension EstimateOrderViewController: MainTextFieldDelegate {
    func getTextField(text: String, type: ViewType) {
        
    }
}

// MARK: - Public methods
extension EstimateOrderViewController: PanModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
}

// MARK: - StarsStackView Delegate
extension EstimateOrderViewController: StarsStackViewDelegate {
    func changeRate(rate: Int) {
        if rate > 0 {
            confirmButton.isEnabledButton = true
        }
    }
}
