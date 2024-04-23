//
//  RegisterViewe.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/17/24.
//

import SwiftUI


#Preview {
    RegisterView()
}

struct RegisterView: View {
    @StateObject var registerViewModel = RegisterViewModel()
    @EnvironmentObject var redirectionModel: RedirectionModel
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            if registerViewModel.isRegistering {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                Text("Register")
                    .font(.title)
                    .padding(.bottom, 20)
                
                CustomNameTextField(text: $registerViewModel.name)
                CustomEmailTextField(text: $registerViewModel.email)
                    .padding(.bottom, 8)
                
                CustomPasswordTextField(text: $registerViewModel.password, placeholder: "Enter your password")
                    .padding(.bottom, 8)
                
                CustomPasswordTextField(text: $registerViewModel.confirmPassword, placeholder: "Confirm password")
                    .padding(.bottom, 8)
                
                Picker("User Type", selection: $registerViewModel.userType) {
                    ForEach(UserType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 8)
                
                Button(action: {
                    registerViewModel.register()
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(17.5)
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 27)
                
                if let error = registerViewModel.registrationError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                }
            }
            Spacer()
        }
        .padding()
        .background(Colors.backgroundColor)
        .navigationTitle("Register")
        .navigationBarHidden(true)
        .onReceive(registerViewModel.userDataSavedPublisher) { completion in
            showAlert = true
               }
        .alert(isPresented: $showAlert) {
                     // Alert to inform the user
                     Alert(
                         title: Text("Success"),
                         message: Text("User data saved successfully."),
                         dismissButton: .default(Text("OK")) {
                             presentationMode.wrappedValue.dismiss()
                         }
                     )
                 }
    }
}

enum UserType: String, CaseIterable {
    case parent
    case child
    
    var isParent: Bool {
        return self == .parent
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}


struct CustomNameTextField: View {
    @Binding var text: String
    @State private var isValid = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Name")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.33333333329999998, green: 0.33333333329999998, blue: 0.33333333329999998))
            
            TextField("Enter your name", text: $text)
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
            isValid = validateName(newValue)
        }
        
        if !isValid {
            Text("Invalid Name")
                .font(.system(size: 14))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func validateName(_ name: String) -> Bool {
        // Add your name validation logic here
        return name.count >= 2 // For example, a valid name has at least 2 characters
    }
}
