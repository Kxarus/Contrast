//
//  TrustArrangementPresenter.swift
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

protocol TrustArrangementPresentationLogic {
    func presentData(response: TrustArrangement.Model.Response.ResponseType)
}

final class TrustArrangementPresenter {
    
    // MARK: - External vars
    weak var viewController: TrustArrangementDisplayLogic?
    
}

// MARK: - Presentation logic
extension TrustArrangementPresenter: TrustArrangementPresentationLogic {
    
    func presentData(response: TrustArrangement.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension TrustArrangementPresenter {
    
}