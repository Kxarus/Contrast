//
//  ContactsPresenter.swift
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

protocol ContactsPresentationLogic {
    func presentData(response: Contacts.Model.Response.ResponseType)
}

final class ContactsPresenter {
    
    // MARK: - External vars
    weak var viewController: ContactsDisplayLogic?
    
}

// MARK: - Presentation logic
extension ContactsPresenter: ContactsPresentationLogic {
    
    func presentData(response: Contacts.Model.Response.ResponseType) {
        switch response {
            //case .some:
        }
    }
}

//  MARK: - Private  methods
private extension ContactsPresenter {
    
}