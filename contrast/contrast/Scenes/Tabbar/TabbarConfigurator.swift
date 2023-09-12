//
//  TabbarConfigurator.swift
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

final class TabbarConfigurator {
    
    static let shared = TabbarConfigurator()
    private init() {}
    
    func configure(_ viewController: TabbarViewController) {
        let service = NetworkService()
        let interactor = TabbarInteractor(service: service)
        let presenter = TabbarPresenter()
        let router = TabbarRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}