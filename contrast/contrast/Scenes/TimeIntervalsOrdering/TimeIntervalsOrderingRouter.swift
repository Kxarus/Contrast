//
//  TimeIntervalsOrderingRouter.swift
//  contrast
//
//  Created by Roman Kiruxin on 20.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PanModal

protocol TimeIntervalsOrderingRoutingLogic {
    func routeToExpressInfo()
    func routeToOrdering(selectedDate: String, selectedTime: String, addressData: UserAddressRequest, isSaveAddress: Bool)
}

protocol TimeIntervalsOrderingDataPassing {
    var dataStore: TimeIntervalsOrderingDataStore? { get }
}

final class TimeIntervalsOrderingRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: TimeIntervalsOrderingViewController?
    var dataStore: TimeIntervalsOrderingDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension TimeIntervalsOrderingRouter: TimeIntervalsOrderingRoutingLogic {
    func routeToOrdering(selectedDate: String, selectedTime: String, addressData: UserAddressRequest, isSaveAddress: Bool) {
        let vc = OrderingViewController()
        vc.router?.dataStore?.selectedDate = selectedDate
        vc.router?.dataStore?.selectedTime = selectedTime
        vc.router?.dataStore?.addressData = addressData
        vc.router?.dataStore?.isSaveAddress = isSaveAddress
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToExpressInfo() {
        let vc = TrustArrangementViewController()
        vc.router?.dataStore?.image = R.image.expressInfoImage()
        vc.router?.dataStore?.title = R.string.localizable.expressDelivery()
        vc.router?.dataStore?.desc = R.string.localizable.mocExpressDesc()
        viewController?.presentPanModal(vc)
    }
}

// MARK: - Data passing
extension TimeIntervalsOrderingRouter: TimeIntervalsOrderingDataPassing {
    
}
