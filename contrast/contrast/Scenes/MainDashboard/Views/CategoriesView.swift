//
//  ProposalsTableViewCell.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 10.07.2023.
//

import UIKit

protocol CategoriesViewDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class CategoriesView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .mainBackgroundColor
        return cv
    }()
    
    weak var delegate: CategoriesViewDelegate?
    
    private let sectionInserts = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 16)
    private var selectedCategories: Int?
    private var catalog: [CategoryModel] = []
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PrivateMethods
private extension CategoriesView {
    private func setup() {
        backgroundColor = .mainBackgroundColor
        
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(cellTypes: [CategoriesViewCell.self])
    }
    
    private func setupConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

// MARK: - PublicMethods
extension CategoriesView {
    func setupCell(with catalog: [CategoryModel], selectedCategories: Int) {
        self.catalog = catalog
        self.selectedCategories = selectedCategories
        collectionView.reloadData()
    }
    
    func selectedCategory(with index: Int) {
        self.selectedCategories = index
        collectionView.reloadData()
    }
}

//MARK: - CollectionViewDelegate and DataSource
extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withType: CategoriesViewCell.self, for: indexPath)
        cell.setupCell(model: (catalog[item]))
        
        if item == selectedCategories {
            cell.setSelected(true)
        } else {
            cell.setSelected(false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategories = indexPath.item
        delegate?.didSelectItem(at: selectedCategories!)
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 60)
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
