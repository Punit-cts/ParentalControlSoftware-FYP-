//
//  LoginView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/17/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

#Preview {
    LoginView()
}


struct LoginView: View {
    @State  var email = "amritduwal1@gmail.com"
    @State var password = "Nepal@123"
    @State  var isLoggedIn = false
    @State  var loginError: String?
    @State  var isLoggingIn = false // Add isLoggingIn state
    @EnvironmentObject var redirectionModel: RedirectionModel
    @State  var navigateToOtpView = false
    
    var body: some View {
            VStack {
                if isLoggingIn {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Welcome")
                        .font(.system(size: 25, weight: .medium))
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("To Parental Control Software")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Ensuring a Safe Digital Space for Your Child")
                        .font(.system(size: 14))
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer().frame(height: 30)
                    
                    CustomEmailTextField(text: $email)
                        .padding(.bottom, 8)
                    
                    CustomPasswordTextField(text: $password, placeholder: "Enter your password")
                        .padding(.bottom, 8)
                    
                    Button(action: {
                        signIn()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(17.5)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 27)
                    
                    if let error = loginError {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Register")
                            .foregroundColor(.blue)
                            .font(.system(size: 14))
                            .padding(.bottom, 20)
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color(red: 0.81346767070000003, green: 0.99063362880000005, blue: 1))
            .navigationTitle("Login")
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: OtpView(),
                    isActive: $navigateToOtpView,
                    label: { EmptyView() }
                )
            )
    }
    
    func signIn() {
        isLoggingIn = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoggingIn = false
            if let error = error {
                loginError = error.localizedDescription
            } else {
                GlobalConstants.KeyValues.user = User(email: email)
//                isLoggedIn = true
//                shouldNavigateToDashboard = true
//                redirectionModel.changeCurrentView = .dashboard
                fetchUserType()
            }
        }
    }
    
    func fetchUserType() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID is nil")
            return
        }
        
        isLoggingIn = true
        // Assuming you're using Firestore
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { document, error in
            var isParent: Bool = false
            isLoggingIn = false
            if let document = document, document.exists {
                if let userType = document.data()?["userType"] as? String {
                    isParent = userType == "parent"
                    GlobalConstants.KeyValues.user = User(email: GlobalConstants.KeyValues.user?.email, isParent: userType == "parent", name: document.data()?["name"] as? String ?? "" )
                    print("User type: \(userType)")
                    // Do something with the user type (e.g., update UI)
                } else {
                    print("User type not found")
                }
            } else {
                print("Document does not exist")
            }
            if isParent {
                navigateToOtpView = true
            } else {
                redirectionModel.changeCurrentView = .dashboard
            }
        }
        
    }

}


struct CustomEmailTextField: View {
    @Binding var text: String
    @State private var isValid = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Email")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.33333333329999998, green: 0.33333333329999998, blue: 0.33333333329999998))
            
            TextField("Enter your email", text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(isValid ? 0.2 : 0.6), lineWidth: 1)
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
                .foregroundColor(.black)
        }
        .onChange(of: text) { newValue in
            isValid = validateEmail(newValue)
        }
        
        if !isValid {
            Text("Invalid Email")
                .font(.system(size: 14))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let validEmail = email.contains("@")
        return validEmail
    }
}


struct CustomPasswordTextField: View {
    @Binding var text: String
    @State private var isValid = true
    @State private var isSecureTextEntry = true
    var placeholder: String // Placeholder for the text field
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if !placeholder.isEmpty {
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.33333333329999998, green: 0.33333333329999998, blue: 0.33333333329999998))
            }
            
            HStack {
                if isSecureTextEntry {
                    SecureField(text, text: $text)
                } else {
                    TextField(text, text: $text)
                }
                
                Button(action: {
                    isSecureTextEntry.toggle()
                }) {
                    Image(systemName: isSecureTextEntry ? "eye.slash" : "eye")
                        .foregroundColor(Color(red: 0.33333333329999998, green: 0.33333333329999998, blue: 0.33333333329999998))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(isValid ? 0.2 : 0.6), lineWidth: 1)
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .foregroundColor(.black)
        }
        .onChange(of: text) { newValue in
            isValid = validatePassword(newValue)
        }
        
        if !isValid {
            Text("Invalid Password")
                .font(.system(size: 13))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func validatePassword(_ password: String) -> Bool {
        // Add your password validation logic here
        return password.count >= 6 // For example, a valid password has at least 6 characters
    }
}
