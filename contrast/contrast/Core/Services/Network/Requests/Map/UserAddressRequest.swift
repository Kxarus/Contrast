//
//  UserAddressRequest.swift
//  contrast
//
//  Created by Roman Kiruxin on 20.07.2023.
//

import Foundation

struct UserAddressRequest: Encodable {
    var city: String
    var street: String
    var house: String
    var latitude: Double
    var longitude: Double
    var type: Int
    var comment: String
    var intercom: String
    var entrance: String
    var floor: String
    var flat: String
}
