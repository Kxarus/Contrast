//
//  OrderingPromocodeRequest.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 19.07.2023.
//

import Foundation

struct OrderPromocodeRequest: Encodable {
    let items: [PromocodeOrderItem]
    let promocode: String?
}

struct PromocodeOrderItem: Encodable {
    let id: Int
    let count: Int
    let additionalServices: [PromocodeAdditionalServices]
}

struct PromocodeAdditionalServices: Encodable {
    let id: Int
    let count: Int
}
