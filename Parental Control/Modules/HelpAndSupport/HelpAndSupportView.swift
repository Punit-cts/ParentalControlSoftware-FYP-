//
//  HelpAndSupportView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/20/24.
//


import SwiftUI

struct HelpAndSupportView: View {
    var body: some View {
        VStack(spacing: 20) {
//            Text("Help & Support")
//                .font(.title)
//                .foregroundColor(Colors.darkerGreyColor)
            Spacer()
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(spacing: 10) {
                Button(action: {
                    // Email action
                    guard let url = URL(string: "mailto:punitthakali@parentalcontrol.com") else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Email: punitthakali@parentalcontrol.com")
                        .font(.headline)
                        .foregroundColor(Colors.darkerGreyColor)
                }
                
                Button(action: {
                    // Call action
                    guard let url = URL(string: "tel://+9779842225362") else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Contact Number:")
                        .font(.headline)
                        .foregroundColor(Colors.darkerGreyColor)
                    +
                    Text(" +977 9842225362")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Colors.backgroundColor)
        .navigationTitle("Help & Support")
    }
}

struct HelpAndSupportView_Previews: PreviewProvider {
    static var previews: some View {
        HelpAndSupportView()
    }
}
