//
//  OrderPhotoCollectionViewCell.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 18.07.2023.
//

import Foundation

import UIKit
import Kingfisher

protocol OrderPhotoCollectionViewCellDelegate: AnyObject {
    func deletePhoto(photoNumber: Int)
    func routeToPhotoComments()
}

final class OrderPhotoCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(R.image.commentPhotoOrder(), for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(R.image.deletePhotoInOrder(), for: .normal)
        return button
    }()
    
    weak var delegate: OrderPhotoCollectionViewCellDelegate?
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
private extension OrderPhotoCollectionViewCell {
    private func setup() {
        
        layer.cornerRadius = 6
        addSubview(photoImageView)
        addSubview(commentButton)
        addSubview(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(deleteTap), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(routeToPhotoComments), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(self)
        }
        
        commentButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.height.equalTo(44)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.height.equalTo(44)
        }
    }
    
    @objc private func deleteTap() {
        delegate?.deletePhoto(photoNumber: photoNumber)
    }
    
    @objc private func routeToPhotoComments() {
        delegate?.routeToPhotoComments()
    }
}

// MARK: - Public methods
extension OrderPhotoCollectionViewCell {
    func setupCellWithPhoto(image: UIImage, photoNumber: Int) {
        deleteButton.isHidden = false
        photoImageView.isHidden = false
        photoImageView.image = image
        self.photoNumber = photoNumber
    }
}
