//
//  ContentView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/14/24.
//

import SwiftUI

struct AppUsageData {
    let appName: String
    let usageTime: Double // in minutes
}

//struct GraphView: View {
//    let appUsageData: [AppUsageData]
//
//    var body: some View {
//        VStack {
//            Text("App Usage List")
//                .font(.title)
//                .padding()
//
//            List(appUsageData, id: \.appName) { data in
//                VStack(alignment: .leading) {
//                    Text("\(data.appName)")
//                        .font(.headline)
//                    Text("\(data.usageTime, specifier: "%.0f") minutes")
//                        .font(.subheadline)
//                }
//            }
//        }
//        .padding()
//    }
//}





//struct GraphView: View {
//    let appUsageData: [AppUsageData]
//
//    var body: some View {
//        VStack {
//            Text("App Usage List")
//                .font(.title)
//                .padding()
//
//            List {
//                ForEach(appUsageData, id: \.appName) { data in
//                    VStack(alignment: .leading) {
//                        Text("\(data.appName)")
//                            .font(.headline)
//                        Text("\(data.usageTime, specifier: "%.0f") minutes")
//                            .font(.subheadline)
//                    }
//                    .contextMenu {
//                        Button(action: {
//                            // Perform lock action
//                        }) {
//                            Label("Lock", systemImage: "lock.fill")
//                        }
//                    }
//                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                        Button(action: {
//                            // Perform delete action
//                        }) {
////                            Label("Lock")
//                            Text("Lock")
//                        }
//                        .tint(.red)
//                    }
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//
//struct ContentView: View {
//    @State private var appUsageData: [AppUsageData] = []
//
//    var body: some View {
//        VStack {
//            if appUsageData.isEmpty {
//                Text("Loading...")
//            } else {
//                GraphView(appUsageData: appUsageData)
//            }
//        }
//        .onAppear {
//            fetchData()
//        }
//    }
//
//    func fetchData() {
//        // Simulated data fetching from a database or API
//        let simulatedData: [AppUsageData] = [
//            AppUsageData(appName: "Messenger", usageTime: 15),
//            AppUsageData(appName: "Facebook", usageTime: 10),
//            // Add more data here...
//        ]
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            // Simulate delay to mimic network request
//            self.appUsageData = simulatedData
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//




//
//
//
//
//
////  ContentView.swift
////  Worklog
////
////  Created by Mobile Programming  on 21/08/23.
////
//
//import SwiftUI
//import DeviceActivity
//import FamilyControls
//
//struct ContentView: View {
//    let ac = AuthorizationCenter.shared
//    
//    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
//
//    @State private var filter = DeviceActivityFilter(
//        segment: .daily(
//            during: Calendar.current.dateInterval(
//               of: .day, for: .now
//            )!
//        ),
//        users: .all,
//        devices: .init([.iPhone, .iPad])
//    )
//    
//    
//    var body: some View {
//        ZStack {
////            DeviceActivityReport(context, filter: filter)
////            LoginView()
////            ProfileView(isLoggedOut: .constant(false))
//        }.onAppear{
////            Task {
////                do {
////                    try await ac.requestAuthorization(for: .individual)
////                }
////                catch {
////                    // Some error occurred
////                }
////            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//



import SwiftUI
import FamilyControls

struct ContentView: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false
    
    var body: some View {
//        Button("Select Apps to Discourage") {
//            isPresented = true
//        }
//        .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
//        Button("Start Monitoring") {
//            model.initiateMonitoring()
//        }
        
        LoginView()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
