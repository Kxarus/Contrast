//
//  UserAddressResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct UserAddressResponse: Decodable {
    let id: Int?
    let city: String?
    let street: String?
    let house: String?
    let latitude: Double?
    let longitude: Double?
    let type: Int?
    let comment: String?
    let intercom: String?
    let entrance: String?
    let floor: String?
    let flat: String?
}
