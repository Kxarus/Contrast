//
//  ZonesGeolocateResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct ZonesGeolocateResponse: Decodable {
    let id: Int?
    let intervals: [TimeIntervalResponse]
    let isExpress: Bool?
    let deliveryPrice: Float?
    let minOrderSum: Float?
}

struct TimeIntervalResponse: Decodable {
    let date: String?
    let time: [IntervalResponse]
}

struct IntervalResponse: Decodable {
    let from: String?
    let to: String?
}
