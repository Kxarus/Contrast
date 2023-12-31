//
//  SmsConfirmConfigurator.swift
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

final class SmsConfirmConfigurator {
    
    static let shared = SmsConfirmConfigurator()
    private init() {}
    
    func configure(_ viewController: SmsConfirmViewController) {
        let service = NetworkService()
        let interactor = SmsConfirmInteractor(service: service)
        let presenter = SmsConfirmPresenter()
        let router = SmsConfirmRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
