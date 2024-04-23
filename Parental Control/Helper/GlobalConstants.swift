//
//  GlobalConstants.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/19/24.
//

import Foundation

struct GlobalConstants {
    
    struct KeyValues {
        static var pushNotifications: [PushNotification]?  {
            get {
                return decode(key: "pushNotifications") ?? []
            }
            set {
                encodeAndSave(key: "pushNotifications", value: newValue)
            }
        }
        
        static var restriction: Restriction? {
            get {
                return decode(key: "restriction")
            }
            set {
                encodeAndSave(key: "restriction", value: newValue)
            }
        }
        
        
        
        static var user: User? {
            get {
                return decode(key: "user")
            }
            set {
                encodeAndSave(key: "user", value: newValue)
            }
        }
        
        static var fcmToken: String? {
            get {
                return decode(key: "fcmToken")
            }
            set {
                encodeAndSave(key: "fcmToken", value: newValue)
            }
        }
        
        static private func encodeAndSave<T: Encodable>(key: String, value: T) {
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        
        
        static private func decode<T: Decodable>(key: String) -> T? {
            if let data = UserDefaults.standard.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: data)
            }
            return nil
        }

            
    }
}
