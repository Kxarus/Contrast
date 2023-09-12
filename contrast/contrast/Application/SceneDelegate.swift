//
//  SceneDelegate.swift
//  contrast
//
//  Created by Roman Kiruxin on 27.06.2023.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import Alamofire
import YandexMobileMetrica
import YandexMapsMobile

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let application = UIApplication.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        removeUserDefaults()
        setupYandexMap()
        setupAppMetric()

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        UserDefaultsWorker.registerActiveAppFirstLaunch(true)
        
        if UserDefaultsWorker.fetchActiveDeviceToken() == nil && UserDefaultsWorker.fetchActiveAppFirstLaunch() == false {
            setupFirebasePushNotifications(with: application)
        }
        
        if UserDefaultsWorker.fetchActiveAppFirstLaunch() == true {
            let vc = OnBoardingViewController()
            setupRootVC(windowScene: windowScene, vc: vc)
        } else {
            if UserDefaultsWorker.fetchPincodeIsSet() == true {
                let vc = PincodeSetViewController()
                setupRootVC(windowScene: windowScene, vc: vc)
            } else {
                let vc = TabbarViewController()
                setupRootVC(windowScene: windowScene, vc: vc)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

// MARK: - Private Methods

private extension SceneDelegate {
    private func setupYandexMap() {
        YMKMapKit.setApiKey(Constants.YANDEXMAPKEY)
        YMKMapKit.sharedInstance()
    }
    
    private func setupAppMetric() {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: Constants.YANDEXMETRIKAKEY)
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    private func setupRootVC(windowScene: UIWindowScene, vc: UIViewController) {
        let window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.isNavigationBarHidden = true
        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func removeUserDefaults() {
        UserDefaultsWorker.removeActiveSearchAddress()
//        UserDefaultsWorker.removeActiveAccessToken()
//        UserDefaultsWorker.removeActiveRefreshToken()
//        UserDefaultsWorker.removeActiveUserPhone()
    }
}

// MARK: - FireBase Delegate
extension SceneDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
    
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
            print("Success in APNs registry")
        }
        
        application.registerForRemoteNotifications()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
            
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        return [[.banner, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
          
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
    }
}
