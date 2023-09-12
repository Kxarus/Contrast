//
//  ProfileInteractor.swift
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

protocol ProfileBusinessLogic {
    func make(request: Profile.Model.Request.RequestType)
}

protocol ProfileDataStore: AnyObject {
    
}

final class ProfileInteractor {
    
    // MARK: - External vars
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension ProfileInteractor: ProfileBusinessLogic {
    
    func make(request: Profile.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension ProfileInteractor: ProfileDataStore  {
   
}

// MARK: - Private methods
private extension ProfileInteractor {
    
}
