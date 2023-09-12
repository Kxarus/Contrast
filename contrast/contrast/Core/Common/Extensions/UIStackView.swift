//
//  UIStackView.swift
//  contrast
//
//  Created by Александра Орлова on 13.07.2023.
//

import UIKit

extension UIStackView {
    func removeAllArrangedViews() {
        let arrangedSubviewsCopy = arrangedSubviews
        for view in arrangedSubviewsCopy {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
