//
//  addPhotosInOrderingViewController.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 18.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PanModal

protocol addPhotosInOrderingDisplayLogic: AnyObject {
    func display(viewModel: addPhotosInOrdering.Model.ViewModel.ViewModelType)
}

final class addPhotosInOrderingViewController: UIViewController {
    
    // MARK: - IBOutlets
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.photoComment()
        label.textColor = .textLight
        label.font = GeneralFonts.generalRegular15
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let addPhotoButton: MainButton = {
        let button = MainButton()
        button.setupStyle()
        button.setTitle(R.string.localizable.addOrderPhoto(), for: .normal)
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
        button.setupStyle()
        button.setTitle(R.string.localizable.confirm(), for: .normal)
        button.isEnabledButton = false
        return button
    }()
    
    // MARK: - External vars
    var panScrollable: UIScrollView?
    var interactor: addPhotosInOrderingBusinessLogic?
    var router: (NSObjectProtocol & addPhotosInOrderingRoutingLogic & addPhotosInOrderingDataPassing)?
    
    // MARK: - Internal vars
    private var images = [UIImage]()
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        addPhotosInOrderingConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addPhotosInOrderingConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension addPhotosInOrderingViewController: addPhotosInOrderingDisplayLogic {
    
    func display(viewModel: addPhotosInOrdering.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension addPhotosInOrderingViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        view.addSubview(descriptionLabel)
        view.addSubview(addPhotoButton)
        view.addSubview(photosCollectionView)
        view.addSubview(confirmButton)
        
        confirmButton.addTarget(self, action: #selector(routeToOrdering), for: .touchUpInside)
        addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        setupNavBar(withTitle: "", and: R.string.localizable.addPhotosItems(), dismiss: true)
        setupCollectionview()
        setupConstraints()
    }
    
    private func setupCollectionview() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(cellTypes: [OrderPhotoCollectionViewCell.self])
    }
    
    private func setupConstraints() {
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(27)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        addPhotoButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(descriptionLabel)
            $0.height.equalTo(46)
        }
        
        photosCollectionView.snp.makeConstraints {
            $0.top.equalTo(addPhotoButton.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(descriptionLabel)
            $0.height.equalTo(171)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(descriptionLabel)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(9)
            $0.height.equalTo(46)
        }
    }
    
    @objc private func routeToOrdering() {
        let photoIds = images.map { $0.hashValue }
        UserDefaultsWorker.saveOrderPhotos(photoIds)
        self.router?.routeToOrdering()
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
extension addPhotosInOrderingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: OrderPhotoCollectionViewCell.self, for: indexPath)
        cell.setupCellWithPhoto(image: images[indexPath.row], photoNumber: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension addPhotosInOrderingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 156, height: 171)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}


// MARK: - UIImagePickerControllerDelegate
extension addPhotosInOrderingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            images.append(image)
            photosCollectionView.reloadData()
            confirmButton.isEnabledButton = !images.isEmpty
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
extension addPhotosInOrderingViewController: OrderPhotoCollectionViewCellDelegate {
    func routeToPhotoComments() {
        print("route to photo comment")
    }
    
    func deletePhoto(photoNumber: Int) {
        images.remove(at: photoNumber)
        photosCollectionView.reloadData()
        confirmButton.isEnabledButton = !images.isEmpty
    }
}

// MARK: - Public methods
extension addPhotosInOrderingViewController {
    
}

