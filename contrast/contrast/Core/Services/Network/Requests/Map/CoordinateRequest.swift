//
//  CoordinateRequest.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct CoordinateRequest: Encodable {
    let lat: Double
    let lon: Double
}

extension CoordinateRequest {
    func setupParams() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["lat"] = lat
        parameters["lon"] = lon
        return parameters
    }
}
