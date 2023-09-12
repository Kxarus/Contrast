//
//  OrderingPromocodeResponse.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 19.07.2023.
//

import Foundation

struct OrderPromocodeResponse: Decodable {
    let sum: Int?
    let discountSum: Int?
    let promocodeResponse: String?
}
