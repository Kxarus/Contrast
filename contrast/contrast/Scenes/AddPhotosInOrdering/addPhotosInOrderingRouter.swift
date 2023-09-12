//
//  addPhotosInOrderingRouter.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 18.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol addPhotosInOrderingRoutingLogic {
    func routeToOrdering()
}

protocol addPhotosInOrderingDataPassing {
    var dataStore: addPhotosInOrderingDataStore? { get }
}

final class addPhotosInOrderingRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: addPhotosInOrderingViewController?
    var dataStore: addPhotosInOrderingDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension addPhotosInOrderingRouter: addPhotosInOrderingRoutingLogic {
    func routeToOrdering() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Data passing
extension addPhotosInOrderingRouter: addPhotosInOrderingDataPassing {
    
}
