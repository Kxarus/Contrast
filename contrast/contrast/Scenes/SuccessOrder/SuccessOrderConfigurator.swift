//
//  SuccessOrderConfigurator.swift
//  contrast
//
//  Created by Roman Kiruxin on 21.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

final class SuccessOrderConfigurator {
    
    static let shared = SuccessOrderConfigurator()
    private init() {}
    
    func configure(_ viewController: SuccessOrderViewController) {
        let service = NetworkService()
        let interactor = SuccessOrderInteractor(service: service)
        let presenter = SuccessOrderPresenter()
        let router = SuccessOrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
