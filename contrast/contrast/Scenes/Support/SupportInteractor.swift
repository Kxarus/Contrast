//
//  SupportInteractor.swift
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

protocol SupportBusinessLogic {
    func make(request: Support.Model.Request.RequestType)
}

protocol SupportDataStore: AnyObject {
    
}

final class SupportInteractor {
    
    // MARK: - External vars
    var presenter: SupportPresentationLogic?
    var worker: SupportWorker?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension SupportInteractor: SupportBusinessLogic {
    
    func make(request: Support.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension SupportInteractor: SupportDataStore  {
   
}

// MARK: - Private methods
private extension SupportInteractor {
    
}
