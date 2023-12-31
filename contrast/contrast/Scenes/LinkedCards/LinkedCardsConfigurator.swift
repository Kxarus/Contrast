//
//  LinkedCardsConfigurator.swift
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

final class LinkedCardsConfigurator {
    
    static let shared = LinkedCardsConfigurator()
    private init() {}
    
    func configure(_ viewController: LinkedCardsViewController) {
        let service = NetworkService()
        let interactor = LinkedCardsInteractor(service: service)
        let presenter = LinkedCardsPresenter()
        let router = LinkedCardsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
