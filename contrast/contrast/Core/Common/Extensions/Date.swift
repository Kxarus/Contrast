//
//  Date.swift
//  contrast
//
//  Created by Roman Kiruxin on 05.07.2023.
//

import Foundation

extension Date {
    func convertToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.dateFormat = format
        let dateValue = dateFormatter.string(from: self)
        return dateValue
    }
}
