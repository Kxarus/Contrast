//
//  AnaliticsService.swift
//  contrast
//
//  Created by Roman Kiruxin on 04.07.2023.
//

import Foundation
import YandexMobileMetrica

protocol AnalyticsServiceProtocol {
    func routeTo(screen: AnalyticsScreens)
}

enum AnalyticsEvents: String {
    case runApp = "RUNAPP"
}

enum AnalyticsScreens: String {
    case login = "LOGIN_SCREEN"
    case verify = "VERIFY_SCREEN"
    case mainDashboard = "MAINDASHBOARD_SCREEN"
    case friendCode = "FRIENDCODE_SCREEN"
    case appcode = "APPCODE_SCREEN"
    case notifications = "NOTIFICATIONS_SCREEN"
    case onBoarding = "ONBOARDING_SCREEN"
}

class AnalyticsService: AnalyticsServiceProtocol {
    static let shared = AnalyticsService()
    private init() {}
    
    func routeTo(screen: AnalyticsScreens) {
        let reporter = YMMYandexMetrica.reporter(forApiKey: Constants.YANDEXMETRIKAKEY)
        reporter?.resumeSession()
        
        reporter?.reportEvent(screen.rawValue)
        
        reporter?.pauseSession()
    }
}

//enum AnaliticsInternalErrorCase {
//    case notFoundNavigationViewControllers
//    case notCreatedViewController
//    case notCastAs(yourClass: Any)
//    case notFoundActiveSpotId
//    case internalLogicError
//    case nilValue
//    case notFoundActiveAccessToken
//    case cloudpaymentsError
//}

