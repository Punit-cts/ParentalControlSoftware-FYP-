//
//  UserSelectionView.swift
//  Parental Control
//
//


import SwiftUI

struct UserSelectionView: View {
    var body: some View {
            GeometryReader { geometry in
                ZStack {
//                    Color(red: 0.81346767070000003, green: 0.99063362880000005, blue: 1)
                    Colors.backgroundColor
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 69) {
                        Text("User Views")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink(destination: NavigationView { LoginView() }) { // Wrap LoginView inside NavigationView
                            UserOptionView(imageName: "Parents", text: "Parents")
                                .frame(width: geometry.size.width - 64, height: 127)
                        }
                        NavigationLink(destination: NavigationView { LoginView() }) { // Wrap LoginView inside NavigationView
                            UserOptionView(imageName: "Children", text: "Children")
                                .frame(width: geometry.size.width - 64, height: 127)
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 32)
                    //                .padding(.top, 179)
                }
            }
//        }
        
    }
}


struct UserOptionView: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(text)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                
                Spacer()
            }
            .frame(height: 127)
            .padding()
            
        }
        .background(Color(.systemBackground))
        
    }
}


struct UserSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserSelectionView()
    }
}
