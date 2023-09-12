//
//  StoriesResponse.swift
//  contrast
//
//  Created by Roman Kiruxin on 07.07.2023.
//

import Foundation

struct StoriesResponse: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let promocode: String?
    let mediaType: Int?
    let mediaLink: String?
    let previewLink: String?
}
