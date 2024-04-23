//
//  DashboardView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/19/24.
//

import SwiftUI

struct BarChart: View {
    let data: [String: Int]
    let barColor: Color
    
    var body: some View {
        VStack {
            ForEach(data.sorted(by: { $0.value > $1.value }), id: \.key) { (label, value) in
                HStack {
                    Text(label)
                    Spacer()
                    RoundedRectangle(cornerRadius: 8)
                        .fill(barColor)
                        .frame(width: CGFloat(value * 10), height: 30) // Adjust the multiplier to control the width of the bar
                    Text("\(value)")
                }
                .padding(.horizontal)
            }
        }
    }
}


struct DashboardView: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false
    @State private var reloadFlag = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Spacer().frame(height: 20)
                    Text("User Information")
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(Colors.darkerGreyColor)
                    HStack {
                        Text("Name:")
                            .padding()
                            .foregroundColor(.blue)
                        Text("\(GlobalConstants.KeyValues.user?.name ?? "")")
                            .padding()
                    }
                    HStack {
                        Text("Role:")
                            .padding()
                            .foregroundColor(.blue)
                        Text(GlobalConstants.KeyValues.user?.isParent == true ? "Parent" : "Child")
                            .padding()
                    }
                    HStack {
                        Text("Alerts:")
                            .padding()
                            .foregroundColor(.blue)
                        Text("\(GlobalConstants.KeyValues.pushNotifications?.count ?? 0)")
                            .padding()
                    }
                }
                
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(32)
                if GlobalConstants.KeyValues.user?.isParent  == true {
                    VStack {
                        Spacer().frame(height: 20)
                        Text("Restrictions")
                        
                        
                        BarChart(data: [
                            "Applications": GlobalConstants.KeyValues.restriction?.applicationsCount ?? 0,
                            "Categories": GlobalConstants.KeyValues.restriction?.categoriesCount ?? 0,
                            "Web": GlobalConstants.KeyValues.restriction?.webCategoriesCount ?? 0
                        ], barColor: .blue)
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .padding(32)
                }
                
                
                if GlobalConstants.KeyValues.user?.isParent  == true {
                    Button(action: {
                        isPresented = true
                    }) {
                        Text("Update Restriction")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(17.5)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 27)
                    .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
                    .onChange(of: isPresented) { isPresented in
                        if !isPresented {
                            removeAndUpdateLocalNotification()
                            reloadFlag.toggle()
                        }
                    }
                }
                
                if GlobalConstants.KeyValues.user?.isParent == false {
                    VStack(spacing: 36) {
                        Text("News Letter")
                            .fontWeight(.heavy)
                            .bold()
                            .foregroundColor(Colors.darkerGreyColor)
                        // Hyperlinks
                        Link(destination: URL(string: "https://www.scirp.org/journal/paperinformation?paperid=107573")!) {
                            Text("SCIRP Paper")
                        }
                        Link(destination: URL(string: "https://files.eric.ed.gov/fulltext/EJ1097402.pdf")!) {
                            Text("ERIC Paper")
                        }
                        Link(destination: URL(string: "https://journals.sagepub.com/doi/10.1177/2158244018824506")!) {
                            Text("SAGE Journal")
                        }
                        Link(destination: URL(string: "https://www.unicef.org/parenting/child-care/keep-your-child-safe-online")!) {
                            Text("UNICEF Article")
                        }
                        Link(destination: URL(string: "https://learnenglishkids.britishcouncil.org/listen-watch/video-zone/five-internet-safety-tips")!) {
                            Text("Internet Safety Tips")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.white)
                    .padding(32)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colors.backgroundColor)
            .id(reloadFlag) // Use id to force view reload
        }
        .background(Colors.backgroundColor)
        
    }
}


func scheduleNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        let applicationsCount = GlobalConstants.KeyValues.restriction?.applicationsCount ?? 0
        let categoriesCount = GlobalConstants.KeyValues.restriction?.categoriesCount ?? 0
        let webCategoriesCount = GlobalConstants.KeyValues.restriction?.webCategoriesCount ?? 0
        
        let totalCount = applicationsCount + categoriesCount + webCategoriesCount
        
        if granted && totalCount > 1 {
            print("Notification authorization granted")
            // Schedule local notification after a minute
            let content = UNMutableNotificationContent()
            content.title = "Restriction 5 Hours have passed"
            content.body = "Applications: \("\(GlobalConstants.KeyValues.restriction?.applicationsCount ?? 0)") \n Categories: \(GlobalConstants.KeyValues.restriction?.categoriesCount ?? 0) \n Webs: \(GlobalConstants.KeyValues.restriction?.webCategoriesCount ?? 0)"
            content.sound = UNNotificationSound.default
            
            let timeIntervalInHours: TimeInterval = 5
            let secondsInHour: TimeInterval = 3600
            let timeIntervalInSeconds = timeIntervalInHours * secondsInHour
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalInSeconds, repeats: false)
            let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        } else {
            print("Notification authorization denied")
        }
    }
}

func removeAndUpdateLocalNotification() {
    // Get all pending notification requests
    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
        // Remove each notification request
        for request in requests {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
        }
        print("All notifications removed")
        scheduleNotification()
    }
}


#Preview {
    DashboardView()
}

