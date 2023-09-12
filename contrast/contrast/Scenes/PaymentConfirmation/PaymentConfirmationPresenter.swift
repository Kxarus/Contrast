//
//  PaymentConfirmationPresenter.swift
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

protocol PaymentConfirmationPresentationLogic {
    func presentData(response: PaymentConfirmation.Model.Response.ResponseType)
}

final class PaymentConfirmationPresenter {
    
    // MARK: - External vars
    weak var viewController: PaymentConfirmationDisplayLogic?
    
}

// MARK: - Presentation logic
extension PaymentConfirmationPresenter: PaymentConfirmationPresentationLogic {
    
    func presentData(response: PaymentConfirmation.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension PaymentConfirmationPresenter {
    
}
