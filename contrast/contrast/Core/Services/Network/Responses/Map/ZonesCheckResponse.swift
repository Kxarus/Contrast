//
//  ZonesCheckResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct ZonesCheckResponse: Decodable {
    let address: AddressData?
    let isInZone: Bool
}

struct AddressData: Decodable {
    let city: String?
    let street: String?
    let house: String?
    let latitude: Double?
    let longitude: Double?
    let address: String?
}

