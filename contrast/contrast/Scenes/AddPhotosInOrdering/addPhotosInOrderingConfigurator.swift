//
//  addPhotosInOrderingConfigurator.swift
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

final class addPhotosInOrderingConfigurator {
    
    static let shared = addPhotosInOrderingConfigurator()
    private init() {}
    
    func configure(_ viewController: addPhotosInOrderingViewController) {
        let service = NetworkService()
        let interactor = addPhotosInOrderingInteractor(service: service)
        let presenter = addPhotosInOrderingPresenter()
        let router = addPhotosInOrderingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
