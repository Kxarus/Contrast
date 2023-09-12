//
//  AddressesSuggestRequest.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//

import Foundation

struct AddressesSuggestRequest: Encodable {
    let address: String
}

extension AddressesSuggestRequest {
    func setupParams() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["address"] = address
        return parameters
    }
}
