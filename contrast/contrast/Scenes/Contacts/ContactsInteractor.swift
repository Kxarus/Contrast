//
//  ContactsInteractor.swift
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

protocol ContactsBusinessLogic {
    func make(request: Contacts.Model.Request.RequestType)
}

protocol ContactsDataStore: AnyObject {
    
}

final class ContactsInteractor {
    
    // MARK: - External vars
    var presenter: ContactsPresentationLogic?
    var worker: ContactsWorker?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension ContactsInteractor: ContactsBusinessLogic {
    
    func make(request: Contacts.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension ContactsInteractor: ContactsDataStore  {
   
}

// MARK: - Private methods
private extension ContactsInteractor {
    
}
