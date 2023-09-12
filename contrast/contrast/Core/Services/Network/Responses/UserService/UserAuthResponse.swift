//
//  UserAuthResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Foundation

struct UserAuthResponse: Decodable {
    let timer: Int?
    let botLink: String?
}
