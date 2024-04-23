//
//  TabbarView.swift
//
//  Created by Amrit Duwal
//

import SwiftUI

enum TabViewItemType: String {
    case home     = "Dashboard"
    case services = "services"
//    case bookings = "bookings"
    case profile  = "profile"
    
    var image: Image {
        switch self {
        case .home:      return Image("home2")
        case .services:  return Image("services")
//        case .bookings:  return Image("bookings")
        case .profile:   return Image("profile")
        }
    }
    
    var selectedImage: Image {
        switch self {
        case .home:      return Image("home.fill")
        case .services:  return Image("services.fill")
//        case .bookings:  return Image("bookings.fill")
        case .profile:   return Image("profile.fill")
        }
    }
    
    var text: Text {
        Text(self.rawValue)
    }
    var navigationTitle: String {
        switch self {
        case .services: return  "Category"
        default: return self.rawValue.capitalizeFirstLetter
        }
    }
    
}

struct TabbarView: View {
    @State var selectedTab: TabViewItemType = .profile
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = Colors.backgroundColor.uiColor
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.greenColor.uiColor]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: Colors.darkerGreyColor.uiColor]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let coloredAppearance = UINavigationBarAppearance()
         coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = Colors.backgroundColor.uiColor
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().isTranslucent = true

    }
    
    var body: some View {
//        _printingChanges()
        return ZStack {
            TabView {
                //                NavigationView {
                DashboardView()
                //                    .navigationBarTitle("Home", displayMode: .inline)
                //                }
                    .navigationViewStyle(.stack)
                    .tabItem { TabViewItem(type: .home, selectedTab: selectedTab) }
                    .onAppear() {
                        self.selectedTab = .home
                    }
//                DashboardView()
//                    .navigationViewStyle(.stack)
//                    .tabItem { TabViewItem(type: .services, selectedTab: selectedTab) }
//                    .onAppear() {
//                        self.selectedTab = .services
//                    }
                ProfileView()
                    .navigationViewStyle(.stack)
                    .tabItem { TabViewItem(type: .profile, selectedTab: selectedTab) }
                    .onAppear() {
                        self.selectedTab = .profile
                    }
            }
            .font(.headline)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(selectedTab.navigationTitle, displayMode: .inline)
        .background(Colors.green)
    }
    
}

struct TabViewItem: View {
    
    var type: TabViewItemType
    var selectedTab: TabViewItemType
    var body: some View {
        VStack {
            type == selectedTab ? type.selectedImage : type.image
            type.text
        }
    }
}

#Preview {
    NavigationView {
        TabbarView()
    }
    
}
