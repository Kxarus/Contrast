//
//  LinkedCardsInteractor.swift
//  contrast
//
//  Created by Александра Орлова on 06.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LinkedCardsBusinessLogic {
    func make(request: LinkedCards.Model.Request.RequestType)
}

protocol LinkedCardsDataStore: AnyObject {
    var cards: [CardModel] { get set }
    var orderModel: NewOrderModel? { get set }
}

final class LinkedCardsInteractor {
    
    // MARK: - External vars
    var presenter: LinkedCardsPresentationLogic?
    var worker: LinkedCardsWorker?
    var cards = [CardModel]()
    var orderModel: NewOrderModel?
    
    // MARK: - Internal vars
    private let service: Services
    
    init(service: NetworkServiceable) {
        self.service = Services(service: service)
    }
}

// MARK: - Business logic
extension LinkedCardsInteractor: LinkedCardsBusinessLogic {
    
    func make(request: LinkedCards.Model.Request.RequestType) {
        switch request {
            //case .some:
        }
    }
}

// MARK: - Data store
extension LinkedCardsInteractor: LinkedCardsDataStore  {
   
}

// MARK: - Private methods
private extension LinkedCardsInteractor {
    
}
