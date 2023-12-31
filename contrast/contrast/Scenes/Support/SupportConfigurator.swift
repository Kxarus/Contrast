//
//  SupportConfigurator.swift
//  contrast
//
//  Created by Roman Kiruxin on 29.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

final class SupportConfigurator {
    
    static let shared = SupportConfigurator()
    private init() {}
    
    func configure(_ viewController: SupportViewController) {
        let service = NetworkService()
        let interactor = SupportInteractor(service: service)
        let presenter = SupportPresenter()
        let router = SupportRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
