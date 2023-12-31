//
//  AddressClarificationInteractor.swift
//  contrast
//
//  Created by Roman Kiruxin on 18.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddressClarificationBusinessLogic {
    func make(request: AddressClarification.Model.Request.RequestType)
}

protocol AddressClarificationDataStore: AnyObject {
    var selectedAddress: AddressDataModel? { get set }
    var activeZones: [ZonesGeolocateInfo] { get set }
}

final class AddressClarificationInteractor {
    
    // MARK: - External vars
    var presenter: AddressClarificationPresentationLogic?
    var worker: AddressClarificationWorker?
    
    // MARK: - Internal vars
    private let service: Services
    var selectedAddress: AddressDataModel?
    var activeZones: [ZonesGeolocateInfo] = []
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension AddressClarificationInteractor: AddressClarificationBusinessLogic {
    
    func make(request: AddressClarification.Model.Request.RequestType) {
        switch request {
            
        }
    }
}

// MARK: - Data store
extension AddressClarificationInteractor: AddressClarificationDataStore  {
   
}

// MARK: - Private methods
private extension AddressClarificationInteractor {
    
}
