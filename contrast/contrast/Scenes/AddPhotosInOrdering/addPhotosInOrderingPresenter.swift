//
//  addPhotosInOrderingPresenter.swift
//  contrast
//
//  Created by Vladimir Kotovchikhin on 18.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol addPhotosInOrderingPresentationLogic {
    func presentData(response: addPhotosInOrdering.Model.Response.ResponseType)
}

final class addPhotosInOrderingPresenter {
    
    // MARK: - External vars
    weak var viewController: addPhotosInOrderingDisplayLogic?
    
}

// MARK: - Presentation logic
extension addPhotosInOrderingPresenter: addPhotosInOrderingPresentationLogic {
    
    func presentData(response: addPhotosInOrdering.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension addPhotosInOrderingPresenter {
    
}
