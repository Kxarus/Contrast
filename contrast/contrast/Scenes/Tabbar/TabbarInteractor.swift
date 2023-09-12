//
//  TabbarInteractor.swift
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

protocol TabbarBusinessLogic {
    func make(request: Tabbar.Model.Request.RequestType)
}

protocol TabbarDataStore: AnyObject {
    
}

final class TabbarInteractor {
    
    // MARK: - External vars
    var presenter: TabbarPresentationLogic?
    var worker: TabbarWorker?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension TabbarInteractor: TabbarBusinessLogic {
    
    func make(request: Tabbar.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension TabbarInteractor: TabbarDataStore  {
   
}

// MARK: - Private methods
private extension TabbarInteractor {
    
}