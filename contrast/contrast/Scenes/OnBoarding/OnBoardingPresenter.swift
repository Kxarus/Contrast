//
//  OnBoardingPresenter.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol OnBoardingPresentationLogic {
    func presentData(response: OnBoarding.Model.Response.ResponseType)
}

final class OnBoardingPresenter {
    
    // MARK: - External vars
    weak var viewController: OnBoardingDisplayLogic?
    
}

// MARK: - Presentation logic
extension OnBoardingPresenter: OnBoardingPresentationLogic {
    
    func presentData(response: OnBoarding.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension OnBoardingPresenter {
    
}
