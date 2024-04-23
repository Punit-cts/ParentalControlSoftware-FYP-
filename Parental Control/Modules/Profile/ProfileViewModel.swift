//
//  ProfileViewModel.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/20/24.
//

import Foundation
import Firebase
import Combine

class ProfileViewModel: ObservableObject {
    let deletionSuccess = PassthroughSubject<Void, Never>()

    func deleteAccount() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error deleting user: \(error.localizedDescription)")
                // Handle error (e.g., show an alert)
            } else {
                print("User deleted successfully")
                self.deletionSuccess.send()
            }
        }
    }
}
