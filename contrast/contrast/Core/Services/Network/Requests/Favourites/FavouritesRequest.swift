//
//  FavouritesRequest.swift
//  contrast
//
//  Created by Roman Kiruxin on 14.07.2023.
//

import Foundation

struct FavouritesRequest: Encodable {
    let id: Int
}

extension FavouritesRequest {
    func setupParams() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["id"] = id
        return parameters
    }
}
