//
//  TabbarRouter.swift
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

protocol TabbarRoutingLogic {
    
}

protocol TabbarDataPassing {
    var dataStore: TabbarDataStore? { get }
}

final class TabbarRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: TabbarViewController?
    var dataStore: TabbarDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension TabbarRouter: TabbarRoutingLogic {
    
}

// MARK: - Data passing
extension TabbarRouter: TabbarDataPassing {
    
}
