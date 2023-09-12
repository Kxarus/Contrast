//
//  TrustArrangementInteractor.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 06.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TrustArrangementBusinessLogic {
    func make(request: TrustArrangement.Model.Request.RequestType)
}

protocol TrustArrangementDataStore: AnyObject {
    var image: UIImage? { get set }
    var title: String? { get set }
    var desc: String? { get set }
}

final class TrustArrangementInteractor {
    
    // MARK: - External vars
    var presenter: TrustArrangementPresentationLogic?
    var worker: TrustArrangementWorker?
    
    // MARK: - Internal vars
    private let service: Services
    var image: UIImage?
    var title: String?
    var desc: String? 
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension TrustArrangementInteractor: TrustArrangementBusinessLogic {
    
    func make(request: TrustArrangement.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension TrustArrangementInteractor: TrustArrangementDataStore  {
   
}

// MARK: - Private methods
private extension TrustArrangementInteractor {
    
}
