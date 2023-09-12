//
//  UserVerifyRequest.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//

import Foundation

struct UserVerifyRequest: Encodable {
    let phone: String
    let code: String
}
