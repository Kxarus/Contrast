//
//  OrderСancellationInteractor.swift
//  contrast
//
//  Created by Владимир on 05.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol OrderСancellationBusinessLogic {
    func make(request: OrderСancellation.Model.Request.RequestType)
}

protocol OrderСancellationDataStore: AnyObject {
    
}

final class OrderСancellationInteractor {
    
    // MARK: - External vars
    var presenter: OrderСancellationPresentationLogic?
    var worker: OrderСancellationWorker?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension OrderСancellationInteractor: OrderСancellationBusinessLogic {
    
    func make(request: OrderСancellation.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension OrderСancellationInteractor: OrderСancellationDataStore  {
   
}

// MARK: - Private methods
private extension OrderСancellationInteractor {
    
}
