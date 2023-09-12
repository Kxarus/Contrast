//
//  PhotoCollectionViewCell.swift
//  contrast
//
//  Created by Александра Орлова on 04.07.2023.
//

import UIKit
import Kingfisher

protocol PhotoCollectionViewCellDelegate: AnyObject {
    func deletePhoto(photoNumber: Int)
}

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.setImage(R.image.clearPhotoIcon(), for: .normal)
        return button
    }()
    
    weak var delegate: PhotoCollectionViewCellDelegate?
    private var photoNumber = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private methods
private extension PhotoCollectionViewCell {
    private func setup() {
        layer.cornerRadius = 6
        addSubview(photoImageView)
        addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteTap), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints({
            $0.top.bottom.leading.trailing.equalTo(self)
        })
        
        deleteButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(44)
            $0.bottom.equalToSuperview().inset(12)
        })
    }
    
    @objc private func deleteTap() {
        delegate?.deletePhoto(photoNumber: photoNumber)
    }
}

// MARK: - Public methods
extension PhotoCollectionViewCell {
    func setupCellWithPhoto(image: UIImage, photoNumber: Int) {
        deleteButton.isHidden = false
        photoImageView.isHidden = false
        photoImageView.image = image
        self.photoNumber = photoNumber
    }
}
