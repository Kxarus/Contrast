//
//  LinkNewCardRouter.swift
//  contrast
//
//  Created by Александра Орлова on 07.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LinkNewCardRoutingLogic {
    func routeToPaymentConfirmation(model: NewOrderModel)
}

protocol LinkNewCardDataPassing {
    var dataStore: LinkNewCardDataStore? { get }
}

final class LinkNewCardRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: LinkNewCardViewController?
    var dataStore: LinkNewCardDataStore?
    
    // MARK: - Internal vars
    func routeToPaymentConfirmation(model: NewOrderModel) {
        let vc = PaymentConfirmationViewController()
        vc.router?.dataStore?.order = model
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Routing logic
extension LinkNewCardRouter: LinkNewCardRoutingLogic {
    
}

// MARK: - Data passing
extension LinkNewCardRouter: LinkNewCardDataPassing {
    
}
