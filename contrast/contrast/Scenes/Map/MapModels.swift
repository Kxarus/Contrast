//
//  MapModels.swift
//  contrast
//
//  Created by Roman Kiruxin on 15.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import YandexMapsMobile

enum Map {
    
    enum Model {
        struct Request {
            enum RequestType {
                case zonesCheck(_ lat: Double,_ lon: Double)
                case zonesAll
                case zonesGeolocate(_ lat: Double,_ lon: Double)
                case fetchUserAddresses
            }
        }
        struct Response {
            enum ResponseType {
                case zonesCheck(_ response: ZonesCheckResponse,_ lat: Double,_ lon: Double)
                case zonesAll(_ response: [ZonesAllResponse])
                case userAddresses(_ response: [UserAddressResponse])
                case zonesGeolocate(_ response: [ZonesGeolocateResponse])
            }
        }
        struct ViewModel {
            enum ViewModelType {
                case presentZonesCheck(_ viewModel: ZonesCheckModel,_ lat: Double? = nil,_ lon: Double? = nil)
                case presentAllZones(_ viewModel: [ZonesAllModel])
                case presentUserAddresses(_ viewModel: [UserAddressModel])
                case presentGeolocate(_ viewModel: [ZonesGeolocateInfo])
            }
        }
    }
}

struct ZonesGeolocateInfo {
    let id: Int
    let intervals: [TimeIntervalModel]
    let isExpress: Bool
    let deliveryPrice: Float
    let minOrderSum: Float
}

struct UserAddressModel {
    let id: Int
    let city: String
    let street: String
    let house: String
    let latitude: Double
    let longitude: Double
    let type: Int
    let comment: String
    let intercom: String
    let entrance: String
    let floor: String
    let flat: String
    var isActive: Bool
}

struct ZonesAllModel {
    let id: Int
    let name: String
    let coordinates: [YMKPoint]
}

struct ZonesCheckModel {
    let address: AddressDataModel?
    let isInZone: Bool
}

struct AddressDataModel: Codable {
    let city: String
    let street: String
    let house: String
    let latitude: Double
    let longitude: Double
    let address: String
}

