//
//  OrderingPresenter.swift
//  contrast
//
//  Created by Kotovchikhin Vladimir on 14.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol OrderingPresentationLogic {
    func presentData(response: Ordering.Model.Response.ResponseType)
}

final class OrderingPresenter {
    
    // MARK: - External vars
    weak var viewController: OrderingDisplayLogic?
    
}

// MARK: - Presentation logic
extension OrderingPresenter: OrderingPresentationLogic {
    
    func presentData(response: Ordering.Model.Response.ResponseType) {
        switch response {
        case .promocodeResponse(let response, let promocode):
            promocodeResponse(response, promocode)
        }
    }
}

//  MARK: - Private  methods
private extension OrderingPresenter {
    private func promocodeResponse(_ response: OrderPromocodeResponse?, _ promocode: String) {
        if let response = response {
            let viewModel = PromocodeResponseModel(promocode: promocode,
                                                   promocodeDescription: response.promocodeResponse ?? "",
                                                   isSuccessPromocode: true)
            viewController?.display(viewModel: .presentPromocodeStatus(viewModel))
            
        } else {
            
            let viewModel = PromocodeResponseModel(promocode: promocode,
                                                   promocodeDescription: R.string.localizable.codeNotCorrectly(),
                                                   isSuccessPromocode: false)
            viewController?.display(viewModel: .presentPromocodeStatus(viewModel))
        }
    }
}
