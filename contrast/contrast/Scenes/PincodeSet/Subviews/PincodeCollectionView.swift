//
//  PincodeCollectionView.swift
//  contrast
//
//  Created by Александра Орлова on 29.06.2023.
//

import UIKit

final class PincodeCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setup(layout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}

// MARK: - Private methods
extension PincodeCollectionView {
    private func setup(layout: UICollectionViewLayout) {
        setCollectionViewLayout(layout, animated: true)
        self.backgroundColor = R.color.mainBackgroundColor()
        self.isScrollEnabled = false
    }
}
