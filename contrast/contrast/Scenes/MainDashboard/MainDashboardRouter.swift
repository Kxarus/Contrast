//
//  MainDashboardRouter.swift
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
import PanModal

protocol MainDashboardRoutingLogic {
    func routeTo(screen: ScreensFromMain)
}

protocol MainDashboardDataPassing {
    var dataStore: MainDashboardDataStore? { get }
}

final class MainDashboardRouter: NSObject {
    
    // MARK: - External vars
    weak var viewController: MainDashboardViewController?
    var dataStore: MainDashboardDataStore?
    
    // MARK: - Internal vars
    
}

// MARK: - Routing logic
extension MainDashboardRouter: MainDashboardRoutingLogic {
    func routeTo(screen: ScreensFromMain) {
        switch screen {
        case .notifications:
            let vc = NotificationsViewController()
            navigatePush(vc)
        case .timeSlots:
            let vc = TimeSlotsViewController()
            navigatePanModal(vc)
        case .pdfView(let nameScreen, let url):
            let vc = DocumentsViewController()
            vc.router?.dataStore?.nameScreen = nameScreen
            vc.router?.dataStore?.receiptUrl = url
            let nc = UINavigationController(rootViewController: vc)
            navigatePresent(nc)
        case .trustArrangement:
            let vc = TrustArrangementViewController()
            vc.router?.dataStore?.image = R.image.boxPackage()
            vc.router?.dataStore?.title = R.string.localizable.titleMessageOrderCancellation()
            vc.router?.dataStore?.desc = R.string.localizable.descriptionMessageTrustArrangement()
            navigatePanModal(vc)
        case .qrCode(let image):
            let vc = QrCodeViewController()
            vc.router?.dataStore?.image = image
            let nc = UINavigationController(rootViewController: vc)
            navigatePresent(nc)
        case .paymentMethod:
            let vc = PaymentMethodViewController()
            navigatePanModal(vc)
        case .estimate:
            let vc = EstimateOrderViewController()
            navigatePanModal(vc)
        case .stories(let model):
            let vc = StoriesViewController()
            let nc = UINavigationController(rootViewController: vc)
            vc.router?.dataStore?.stories = model
            navigatePresent(nc)
        }
    }
}

// MARK: - Data passing
extension MainDashboardRouter: MainDashboardDataPassing {
    
}

//MARK: - Private methods
private extension MainDashboardRouter {
    private func navigatePush(_ vc: UIViewController) {
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigatePresent(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
    
    private func navigatePanModal(_ vc: UIViewController & PanModalPresentable) {
        viewController?.presentPanModal(vc)
    }
}
