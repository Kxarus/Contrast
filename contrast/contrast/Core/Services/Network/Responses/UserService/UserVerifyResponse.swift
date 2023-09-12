//
//  UserVerifyResponse.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//

import Foundation

struct UserVerifyResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let isFirstRegister: Bool
}
