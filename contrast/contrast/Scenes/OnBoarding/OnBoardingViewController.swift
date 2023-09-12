//
//  OnBoardingViewController.swift
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
import SnapKit
import CoreLocation
import FirebaseCore
import FirebaseMessaging

protocol OnBoardingDisplayLogic: AnyObject {
    func display(viewModel: OnBoarding.Model.ViewModel.ViewModelType)
}

final class OnBoardingViewController: UIPageViewController {
    
    // MARK: - IBOutlets
    
    // MARK: - External vars
    var interactor: OnBoardingBusinessLogic?
    var router: (NSObjectProtocol & OnBoardingRoutingLogic & OnBoardingDataPassing)?
    private let analytics = AnalyticsService.shared
    
    // MARK: - Internal vars
    private let locationManager = CLLocationManager()
    private let application = UIApplication.shared
    
    private var pages = [UIViewController]()
    private let initialPage = 0
    private var currentStep = 0
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Display logic
extension OnBoardingViewController: OnBoardingDisplayLogic {
    
    func display(viewModel: OnBoarding.Model.ViewModel.ViewModelType) {
        switch viewModel {
            
        }
    }
}

// MARK: - DataSources
extension OnBoardingViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }

}

// MARK: - Delegates
extension OnBoardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
    }
}


// MARK: - Private methods
private extension OnBoardingViewController {
    private func setupView() {
        view.backgroundColor = .mainBackgroundColor
        
        OnBoardingConfigurator.shared.configure(self)
        setupPageController()
        analytics.routeTo(screen: .onBoarding)
    }
    
    private func setupPageController() {
//        dataSource = self
        delegate = self
        
        let mocDescription = "это текст-рыба, часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной рыбой для текстов на латинице с начала XVI века."
        
        let firstStep = OnBoardingMainViewController()
        firstStep.setupView(image: R.image.firstOnBoarding()!,
                            title: R.string.localizable.onboardingFirstTitle(),
                            description: mocDescription,
                            titleMainButton: R.string.localizable.next(),
                            isAdditionalButtonHidden: true)
        
        let secondStep = OnBoardingMainViewController()
        secondStep.setupView(image: R.image.secondOnBoarding()!,
                             title: R.string.localizable.onboardingSecondTitle(),
                             description: mocDescription,
                             titleMainButton: R.string.localizable.allow(),
                             isAdditionalButtonHidden: false)
        
        let thirdStep = OnBoardingMainViewController()
        thirdStep.setupView(image: R.image.thirdOnBoarding()!,
                            title: R.string.localizable.onboardingThirdTitle(),
                            description: mocDescription,
                            titleMainButton: R.string.localizable.allow(),
                            isAdditionalButtonHidden: false)
        
        let fourthStep = OnBoardingFourthViewController()
        
        firstStep.delegate = self
        secondStep.delegate = self
        thirdStep.delegate = self
        fourthStep.delegate = self
        
        pages.append(firstStep)
        pages.append(secondStep)
        pages.append(thirdStep)
        pages.append(fourthStep)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
}

// MARK: - Public methods
extension OnBoardingViewController {
    
    func goToNextPage(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        setViewControllers([pages[currentStep]], direction: .forward, animated: animated)
    }
}

// MARK: - OnBoardingEvents
extension OnBoardingViewController: OnBoardingEvents {
    func pressMainButton() {
        currentStep += 1
        
        switch currentStep {
        case 1:
            goToNextPage()
        case 2:
            setLocationManager()
        case 3:
            setupFirebasePushNotifications(with: application)
        default:
            break
        }
    }
    
    func pressAdditionalButton() {
        currentStep += 1
        
        switch currentStep {
        case 2:
            if UserDefaultsWorker.fetchActiveDeviceToken() != nil {
                currentStep += 1
                goToNextPage()
            } else {
                goToNextPage()
            }
        case 3:
            setupFirebasePushNotifications(with: application)
            goToNextPage()
        default:
            goToNextPage()
        }
    }
}

// MARK: - OnBoardingEvents
extension OnBoardingViewController: OnBoardingFourthViewControllerDelegate {
    func routeToPincode() {
        UserDefaultsWorker.saveActiveAppFirstLaunch(false)
        router?.routeToPincode()
    }
    
    func routeToLogin() {
        UserDefaultsWorker.saveActiveAppFirstLaunch(false)
        router?.routeToLogin()
    }
}

//MARK: - LocationManager Delegates
extension OnBoardingViewController: CLLocationManagerDelegate {
    
    func setLocationManager() {
        checkLocationAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            if UserDefaultsWorker.fetchActiveDeviceToken() != nil {
                currentStep += 1
            }
            goToNextPage()
        }
    }
     
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
    }
    
}

// MARK: - FireBase Delegate
extension OnBoardingViewController: MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token - \(token)")
            UserDefaultsWorker.saveActiveDevice(token)
        }
    }
    
    private func setupFirebasePushNotifications(with application: UIApplication) {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
            guard success else {
                return
            }
            
            DispatchQueue.main.async {
                self.goToNextPage()
            }
            print("Success in APNs registry")
        }
        
        application.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
            
        return [[.banner, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse) async {
        
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
    }
}