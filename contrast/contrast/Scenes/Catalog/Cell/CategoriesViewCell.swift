//
//  ProposalsCollectionViewCell.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 10.07.2023.
//

import UIKit
import Kingfisher

final class CategoriesViewCell: UICollectionViewCell {
    
    private let containerView: ShadowView = {
        let view = ShadowView()
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = GeneralFonts.generalRegular12
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension CategoriesViewCell {
    private func setupView() {
        backgroundColor = .mainBackgroundColor
        layer.cornerRadius = 9
        clipsToBounds = true
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.bottom.equalToSuperview().inset(2)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-2)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(containerView)
            $0.bottom.equalTo(containerView)
            $0.leading.equalTo(containerView)
            $0.width.equalTo(61)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(13)
            $0.trailing.equalTo(containerView).inset(8)
        }
    }
}

//MARK: - Public methods
extension CategoriesViewCell {
    func setupCell(model: CategoryModel) {
        titleLabel.text = model.title
        
        if let url = URL(string: model.imageUrl) {
            imageView.kf.setImage(with: URL(string: model.imageUrl)) { result in
                switch result {
                case .success:
                    break
                case .failure:
                    self.imageView.image = R.image.catalogDefaultImage()
                }
            }
        } else {
            self.imageView.image = R.image.catalogDefaultImage()
        }
        
    }
    func setSelected(_ selected: Bool) {
        containerView.backgroundColor = selected ? R.color.accent() : .mainBackgroundColor
    }
}


