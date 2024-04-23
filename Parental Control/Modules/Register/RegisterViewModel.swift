//
//  RegisterViewModel.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/20/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var userType = UserType.parent // Default to parent
    @Published var registrationError: String?
    @Published var isRegistering = false // Add isRegistering state
    @Published var name = "" // Add isRegistering state
//    @EnvironmentObject var redirectionModel: RedirectionModel
    
//    var userDataSavedCompletion: (() -> Void)?
    let userDataSavedPublisher = PassthroughSubject<Void, Never>()
    
    func register() {
        guard password == confirmPassword else {
            registrationError = "Passwords do not match"
            return
        }
        
        // Start registering the user
        isRegistering = true
        
        // Register the user with Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // Stop registering the user
            self.isRegistering = false
            
            // Check for errors
            if let error = error {
                // Handle registration error
                self.registrationError = error.localizedDescription
            } else {
                // Registration successful, clear error
                self.registrationError = nil
                
                // Clear password fields
                self.password = ""
                self.confirmPassword = ""
                
                // Save additional user data including user type to Firestore
                self.saveUserData()
            }
        }
    }
    
    private func saveUserData() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        // Access Firestore
        let db = Firestore.firestore()
        
        // Define the data to be saved
        let userData: [String: Any] = [
            "email": email,
            "userType": userType.rawValue,
            "name": name
        ]
        
        // Save the data to Firestore
        db.collection("users").document(currentUser.uid).setData(userData) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
                // Handle error if needed
            } else {
                print("User data saved successfully")
                GlobalConstants.KeyValues.user = User(email: self.email, isParent: self.userType.isParent )
        
                self.userDataSavedPublisher.send()
            }
        }
    }
}

