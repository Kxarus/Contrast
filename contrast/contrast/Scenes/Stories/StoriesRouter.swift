//
//  StoriesRouter.swift
//  contrast
//
//  Created by Александра Орлова on 10.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StoriesRoutingLogic {
    func routeBack()
}

protocol StoriesDataPassing {
    var dataStore: StoriesDataStore? { get }
}

final class StoriesRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: StoriesViewController?
    var dataStore: StoriesDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension StoriesRouter: StoriesRoutingLogic {
    func routeBack() {
        viewController?.dismiss(animated: true)
    }
}

// MARK: - Data passing
extension StoriesRouter: StoriesDataPassing {
    
}
