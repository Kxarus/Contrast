//
//  SearchAddressesRouter.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchAddressesRoutingLogic {
    
}

protocol SearchAddressesDataPassing {
    var dataStore: SearchAddressesDataStore? { get }
}

final class SearchAddressesRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: SearchAddressesViewController?
    var dataStore: SearchAddressesDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension SearchAddressesRouter: SearchAddressesRoutingLogic {
    
}

// MARK: - Data passing
extension SearchAddressesRouter: SearchAddressesDataPassing {
    
}