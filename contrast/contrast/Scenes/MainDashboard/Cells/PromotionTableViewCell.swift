//
//  PromotionCell.swift
//  contrast
//
//  Created by Roman Kiruxin on 30.06.2023.
//

import UIKit

protocol PromotionTableViewCellDelegate: AnyObject {
    func routeToPromo(with model: StoriesModel)
}

final class PromotionTableViewCell: UITableViewCell, Reusable {

    var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .mainBackgroundColor
        return cv
    }()
    
    private var stories: [StoriesModel] = []
    
    weak var delegate: PromotionTableViewCellDelegate?
    private let sectionInserts = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PrivateMethods
private extension PromotionTableViewCell {
    private func setup() {
        backgroundColor = .mainBackgroundColor
        
        contentView.isUserInteractionEnabled = true
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
        registerCells()
    }
    
    private func registerCells() {
        self.collectionView.register(PromotionsCollectionViewCell.self, forCellWithReuseIdentifier: PromotionsCollectionViewCell.cellId)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(self).inset(10)
            $0.bottom.equalTo(self).inset(10)
            $0.leading.equalTo(self).inset(16)
            $0.trailing.equalTo(self).inset(16)
        }
    }
}

// MARK: - PublicMethods
extension PromotionTableViewCell {
    func setupCell(with stories: [StoriesModel]) {
        self.stories = stories
        collectionView.reloadData()
    }
}

//MARK: - CollectionViewDelegate and DataSource
extension PromotionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionsCollectionViewCell.cellId, for: indexPath) as! PromotionsCollectionViewCell
        cell.setupCell(model: stories[item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.routeToPromo(with: stories[indexPath.item])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PromotionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 99, height: 99)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }
}

