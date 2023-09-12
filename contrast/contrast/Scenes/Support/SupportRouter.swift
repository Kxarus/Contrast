//
//  SupportRouter.swift
//  contrast
//
//  Created by Roman Kiruxin on 29.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SupportRoutingLogic {
    
}

protocol SupportDataPassing {
    var dataStore: SupportDataStore? { get }
}

final class SupportRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: SupportViewController?
    var dataStore: SupportDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension SupportRouter: SupportRoutingLogic {
    
}

// MARK: - Data passing
extension SupportRouter: SupportDataPassing {
    
}
