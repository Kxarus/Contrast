//
//  UserAuthRequest.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Foundation

struct UserAuthRequest: Encodable {
    let phone: String
    let type: Int
    
    init(phone: String, type: Int) {
        self.phone = phone
        self.type = type
    }
}
