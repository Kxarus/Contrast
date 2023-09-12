//
//  ZonesAllResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct ZonesAllResponse: Decodable {
    let id: Int?
    let name: String?
    let coordinates: [Double?]
}
