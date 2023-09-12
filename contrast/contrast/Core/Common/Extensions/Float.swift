//
//  Float.swift
//  contrast
//
//  Created by Александра Орлова on 14.07.2023.
//

import Foundation

extension Float {
    var formattedString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        if self.truncatingRemainder(dividingBy: 1) == 0 {
            formatter.maximumFractionDigits = 0
        }

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
