//
//  AppDelegate+Notification.swift

import Firebase
import UIKit

//MARK:- FIREBASE NOTIFICATION
extension AppDelegate : MessagingDelegate {
    
    func setUPFirebase(_ application: UIApplication){
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "")")
        guard let fcmToken = fcmToken else { return }
        GlobalConstants.KeyValues.fcmToken = fcmToken

    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // Print full message.
        print(userInfo)
        //    processAlertNotification(userInfo: userInfo)
        // Parse the notification payload
          if let aps = userInfo["aps"] as? [String: Any],
             let alert = aps["alert"] as? [String: Any],
             let title = alert["title"] as? String,
             let body = alert["body"] as? String {
              
              // Create a PushNotification object
              let pushNotification = PushNotification(title: title, body: body)
              if GlobalConstants.KeyValues.pushNotifications?.count == 0 {
                  GlobalConstants.KeyValues.pushNotifications = [pushNotification]
              } else {
                  GlobalConstants.KeyValues.pushNotifications?.append(pushNotification)
              }

              // Store the notification offline using UserDefaults or another storage solution
//              storeNotification(notification)
              
          }
        // Change this to your preferred presentation option
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Print full message.
        print(userInfo)
        processAlertNotification(userInfo: userInfo)
        completionHandler()
    }
    
    func processAlertNotification(userInfo: [AnyHashable: Any]){
        
        print(userInfo)
    }
    
    private func routeTo(view: UIViewController, from rootViewController: UIViewController?){
        view.hidesBottomBarWhenPushed = true
        if let uiAlertController = rootViewController as? UIAlertController{
            if let tabController = uiAlertController.presentingViewController as? UITabBarController{
                uiAlertController.dismiss(animated: false, completion: nil)
                let viewController = tabController.selectedViewController as? UINavigationController
                viewController?.pushViewController(view, animated: true)
                
            }
        }
        
        if let tabController = rootViewController as? UITabBarController{
            let viewController = tabController.selectedViewController as? UINavigationController
            viewController?.pushViewController(view, animated: true)
        }
        
        if let navigationViewController = rootViewController as? UINavigationController{
            navigationViewController.pushViewController(view, animated: true)
        }
    }
}

//
//extension AppDelegate: RegisterFirebaseTokenAPI {
//
//    private func registerFierebaseToken(token: String) {
//        registerFirebaseToken(fcmToken: token){ message in
//
//        } failure: { error in
//            print(error)
//        }
//
//    }
//}
