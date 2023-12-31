//
//  SupportViewController.swift
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

protocol SupportDisplayLogic: AnyObject {
    func display(viewModel: Support.Model.ViewModel.ViewModelType)
}

final class SupportViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    
    // MARK: - External vars
    var interactor: SupportBusinessLogic?
    var router: (NSObjectProtocol & SupportRoutingLogic & SupportDataPassing)?
    
    // MARK: - Internal vars
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SupportConfigurator.shared.configure(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SupportConfigurator.shared.configure(self)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension SupportViewController: SupportDisplayLogic {
    
    func display(viewModel: Support.Model.ViewModel.ViewModelType) {
        switch viewModel {
            //case .some
        }
    }
}

// MARK: - Private methods
private extension SupportViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
    }
}

// MARK: - Public methods
extension SupportViewController {
    
}


