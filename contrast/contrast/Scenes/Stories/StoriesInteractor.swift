//
//  StoriesInteractor.swift
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

protocol StoriesBusinessLogic {
    func make(request: Stories.Model.Request.RequestType)
}

protocol StoriesDataStore: AnyObject {
    var stories: StoriesModel? { get set }
}

final class StoriesInteractor {
    
    // MARK: - External vars
    var presenter: StoriesPresentationLogic?
    var worker: StoriesWorker?
    var stories: StoriesModel?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension StoriesInteractor: StoriesBusinessLogic {
    
    func make(request: Stories.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension StoriesInteractor: StoriesDataStore  {
   
}

// MARK: - Private methods
private extension StoriesInteractor {
    
}
