//
//  MaskWorker.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Foundation

final class MaskWorker {
    
    class func format(with mask: String, phone: String) -> String {
        var phoneResult = phone
        
        if phone.count == 1 {
            phoneResult.removeAll()
            phoneResult.append("\(phone)")
        }
        
        if phone == "" {
            return ""
        }
        
        let numbers = phoneResult.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    class func removePhoneMask(in string: String) -> String {
        let result = string.filter { (char) -> Bool in
            char != " " && char != "-" && char != "(" && char != ")"
        }.filter { (char) -> Bool in
            char != "+"
        }
        return result
    }
}
