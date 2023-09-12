//
//  CatalogResponse.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 11.07.2023.
//

import Foundation

struct CatalogResponse: Decodable {
    let id: Int?
    let title: String?
    let items: [CatalogItem?]
    let imageUrl: String?
}

struct CatalogItem: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Float?
    let additionalDescription: String?
    let additionalServices: [AditionalService?]
    let isExpressAvailable: Bool?
}

struct AditionalService: Decodable {
    let id: Int?
    let title: String?
    let price: Float?
    let description: String?
}

