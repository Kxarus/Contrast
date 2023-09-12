//
//  OrderingModels.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 14.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Ordering {
    
    enum Model {
        struct Request {
            enum RequestType {
                case checkPromoCode(_ code: String)
                case saveUserAddress(_ address: UserAddressRequest)
            }
        }
        struct Response {
            enum ResponseType {
                case promocodeResponse(_ response: OrderPromocodeResponse?, promocode: String)
            }
        }
        struct ViewModel {
            enum ViewModelType {
                case presentPromocodeStatus(_ viewModel: PromocodeResponseModel)
            }
        }
    }
}

struct PromocodeResponseModel {
    let promocode: String
    let promocodeDescription: String
    let isSuccessPromocode: Bool
}
