//
//  UICollectionView.swift
//  contrast
//
//  Created by Roman Kiruxin on 06.07.2023.
//

import UIKit

extension UICollectionView {
    
    func register(cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach({ self.register($0, forCellWithReuseIdentifier: $0.reuseId) })
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? T else {
            fatalError("\(String(describing: type)) not found")
        }
        return cell
    }
}
