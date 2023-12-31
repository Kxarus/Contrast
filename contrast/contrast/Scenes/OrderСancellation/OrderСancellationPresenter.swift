//
//  OrderСancellationPresenter.swift
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

protocol OrderСancellationPresentationLogic {
    func presentData(response: OrderСancellation.Model.Response.ResponseType)
}

final class OrderСancellationPresenter {
    
    // MARK: - External vars
    weak var viewController: OrderСancellationDisplayLogic?
    
}

// MARK: - Presentation logic
extension OrderСancellationPresenter: OrderСancellationPresentationLogic {
    
    func presentData(response: OrderСancellation.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension OrderСancellationPresenter {
    
}
