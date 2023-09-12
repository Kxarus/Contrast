//
//  PromotionsCollectionViewCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 30.06.2023.
//

import UIKit
import Kingfisher

final class PromotionsCollectionViewCell: UICollectionViewCell {
    static let cellId = "PromotionsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GeneralFonts.generalRegular11
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
private extension PromotionsCollectionViewCell {
    private func setupView() {
        backgroundColor = .mainBackgroundColor
        layer.cornerRadius = 9
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.addSubview(titleLabel)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(9)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

//MARK: - Public methods
extension PromotionsCollectionViewCell {
    func setupCell(model: StoriesModel) {
        titleLabel.text = model.title
        imageView.kf.setImage(with: URL(string: model.previewLink))
        
        imageView.addBlackGradientLayerInBackground(frame: bounds, colors:[.clear, .black])
    }
}
