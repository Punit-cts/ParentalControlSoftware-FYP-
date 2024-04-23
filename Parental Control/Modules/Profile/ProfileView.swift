//
//  ProfileView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/17/24.
//

import SwiftUI

struct ProfileView: View {
    @State var showLogoutAlert = false
    @State var showDeleteAccountAlert = false
    @EnvironmentObject var redirectionModel: RedirectionModel
    @StateObject var profileViewModel =  ProfileViewModel()
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(Colors.darkerGreyColor)
            Text(GlobalConstants.KeyValues.user?.email ?? "")
                .foregroundColor(Colors.darkerGreyColor)
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink {
                    NotificationListView()
                } label: {
                    HStack {
                        Image(systemName: "bell.circle.fill")
                            .foregroundColor(Colors.darkerGreyColor)
                        Text("Notification")
                            .foregroundColor(Colors.darkerGreyColor)
                    }
                    .padding()
                }
                   
//                }
                Divider().padding(.horizontal, 16)
                
                // Help & Support Button
                NavigationLink {
                    HelpAndSupportView()
                } label: {
                    HStack {
                        Image(systemName: "phone.circle.fill")
                            .foregroundColor(Colors.darkerGreyColor)
                        Text("Help & Support")
                            .foregroundColor(Colors.darkerGreyColor)
                    }
                    .padding()
                }
                Divider().padding(.horizontal, 16)
                Button(action: {
                    showLogoutAlert = true
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.circle.fill")
                            .foregroundColor(.red)
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .default(Text("Yes")) {
                            GlobalConstants.KeyValues.user = nil
                            redirectionModel.changeCurrentView = .UserViews
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                Divider().padding(.horizontal, 16)
                // Delete Account Button
                if GlobalConstants.KeyValues.user?.isParent == true {
                    Button(action: {
                        // Delete account action
                        showDeleteAccountAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash.circle.fill")
                                .foregroundColor(.red)
                            Text("Delete Account")
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                    .alert(isPresented: $showDeleteAccountAlert) {
                        Alert(
                            title: Text("Delete Account"),
                            message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                redirectionModel.changeCurrentView = .UserViews
                                profileViewModel.deleteAccount()
                            },
                            secondaryButton: .cancel(Text("Cancel"))
                        )
                    }
                    
                }
                
                
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .background(Colors.backgroundColor)
   
 
   
    }
}

#Preview {
    ProfileView()
}

