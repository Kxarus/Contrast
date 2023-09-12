//
//  PaymentMethodModels.swift
//  contrast
//
//  Created by Александра Орлова on 05.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum PaymentMethod {
    
    enum Model {
        struct Request {
            enum RequestType {
                
            }
        }
        struct Response {
            enum ResponseType {
                
            }
        }
        struct ViewModel {
            enum ViewModelType {
                
            }
        }
    }
}

struct PaymentMethodModel {
    var maxPointsNumber: Int
    var sumWithoutPoints: Float
    var finalSum: Float
    var pointsBackPercent: Int
    var services: [AdditionalService]
    var linkedCards: [CardModel]?
}

struct AdditionalService {
    var title: String
    var description: String
    var sum: Float
    var isSelected: Bool
}

struct CardModel {
    let num: String
    let period: String
    let cvc: String
}

struct NewOrderModel {
    var number: String
    var card: CardModel?
    var sum: Float
}