//
//  OrderingRouter.swift
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

protocol OrderingRoutingLogic {
    func routeToSuccess(_ selectedDate: String,_ selectedTime: String)
}

protocol OrderingDataPassing {
    var dataStore: OrderingDataStore? { get }
}

final class OrderingRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: OrderingViewController?
    var dataStore: OrderingDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension OrderingRouter: OrderingRoutingLogic {
    func routeToSuccess(_ selectedDate: String, _ selectedTime: String) {
        let vc = SuccessOrderViewController()
        vc.router?.dataStore?.selectedDate = selectedDate
        vc.router?.dataStore?.selectedTime = selectedTime
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Data passing
extension OrderingRouter: OrderingDataPassing {
    
}
