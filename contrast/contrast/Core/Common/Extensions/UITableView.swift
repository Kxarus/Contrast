//
//  UITableView.swift
//  contrast
//
//  Created by Roman Kiruxin on 30.06.2023.
//

import UIKit

extension UITableView {
    
    func register(cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach({ self.register($0, forCellReuseIdentifier: $0.reuseId) })
    }
    
    func dequeueReusableCell<T: UITableViewCell & Reusable>(of type: T.Type) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        "\(Self.self)"
    }
}
