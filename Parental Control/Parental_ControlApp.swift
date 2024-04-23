//
//  Parental_ControlApp.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/14/24.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import Firebase

@main
struct Parental_ControlApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
        }
        
    }
}

struct ApplicationSwitcher: View {
    let center = AuthorizationCenter.shared
    let logoutNotification = NotificationCenter.default.publisher(for: .logout)
    @ObservedObject var redirectionModel = RedirectionModel()
    
    var body: some View {
       return NavigationView{
            getView()
                .onReceive(logoutNotification) { notification in
                    if let isLogin = notification.object as? Bool {
                        redirectionModel.changeCurrentView = isLogin ? .UserViews : .dashboard
                    }
                }
        }
       .onAppear {
           Task {
               do {
                   try await center.requestAuthorization(for: .individual)
               } catch {
                   print("Failed to enroll Aniyah with error: \(error)")
               }
           }
       }
        .navigationViewStyle(.stack)
        .environmentObject(redirectionModel)
        
    }
    
    @ViewBuilder func getView() -> some View {
        switch redirectionModel.changeCurrentView {
        case .dashboard: TabbarView()
        case .UserViews:     UserSelectionView()
        }
    }
    
}




class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//            AuthorizationCenter.shared.requestAuthorization { result in
//                switch result {
//                case .success:
//                    print("Success")
//                case .failure(let error):
//                    print("error for screentime is \(error)")
//                }
//            }
//
//            _ = AuthorizationCenter.shared.$authorizationStatus
//                .sink() {_ in
//                switch AuthorizationCenter.shared.authorizationStatus {
//                case .notDetermined:
//                    print("not determined")
//                case .denied:
//                    print("denied")
//                case .approved:
//                    print("approved")
//                @unknown default:
//                    break
//                }
//            }
//            FirebaseApp.configure()
            registerForPushNotifications()
            setUPFirebase(application) // set firebase notification
            return true
        }
     
}


//MARK: Notifications
extension AppDelegate{
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                print("Registered PN")
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        //         Defaults[.deviceToken] = token
        print("Device Token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Failed to register: \(error)")
        }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
}

