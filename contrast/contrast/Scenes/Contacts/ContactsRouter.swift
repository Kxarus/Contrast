//
//  ContactsRouter.swift
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

protocol ContactsRoutingLogic {
    
}

protocol ContactsDataPassing {
    var dataStore: ContactsDataStore? { get }
}

final class ContactsRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: ContactsViewController?
    var dataStore: ContactsDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension ContactsRouter: ContactsRoutingLogic {
    
}

// MARK: - Data passing
extension ContactsRouter: ContactsDataPassing {
    
}
