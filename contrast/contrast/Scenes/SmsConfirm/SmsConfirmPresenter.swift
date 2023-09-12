//
//  SmsConfirmPresenter.swift
//  contrast
//
//  Created by Александра Орлова on 03.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SmsConfirmPresentationLogic {
    func presentData(response: SmsConfirm.Model.Response.ResponseType)
}

final class SmsConfirmPresenter {
    
    // MARK: - External vars
    weak var viewController: SmsConfirmDisplayLogic?
    
}

// MARK: - Presentation logic
extension SmsConfirmPresenter: SmsConfirmPresentationLogic {
    
    func presentData(response: SmsConfirm.Model.Response.ResponseType) {
        switch response {
        case .successUserAuth(let firstRegister):
            viewController?.display(viewModel: .verifyResponse(firstRegister))
        case .failureUserAuth:
            viewController?.display(viewModel: .failureUserAuth)
        case .successSend(let response):
            viewController?.display(viewModel: .successSend(response))
        }
    }
}

//  MARK: - Private  methods
private extension SmsConfirmPresenter {
    
}
