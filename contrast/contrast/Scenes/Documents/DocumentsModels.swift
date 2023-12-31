//
//  DocumentsModels.swift
//  contrast
//
//  Created by Roman Kiruxin on 05.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Documents {
    
    enum Model {
        struct Request {
            enum RequestType {
                case fetchNameScreen
                case fetchUrlReceipt
            }
        }
        struct Response {
            enum ResponseType {
                case nameScreen(String)
                case urlReceipt(_ url: String)
            }
        }
        struct ViewModel {
            enum ViewModelType {
                case presentNameScreen(String)
                case presentUrlReceipt(_ url: String)
            }
        }
    }
}
