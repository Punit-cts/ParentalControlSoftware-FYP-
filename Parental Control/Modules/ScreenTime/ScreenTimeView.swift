

//
//import SwiftUI
//import FamilyControls
//import DeviceActivity
//
//struct ScreenTimeView: View {
//    let center = AuthorizationCenter.shared
//    
//    var body: some View {
//        ZStack {
//            // Your UI content here
//            Text("Hello, World!")
//        }
//        .onAppear {
//            Task {
//                do {
//                    try await center.requestAuthorization(for: .individual)
//                } catch {
//                    print("Failed to enroll Aniyah with error: \(error)")
//                }
//            }
//        }
//    }
//}
//
//struct ScreenTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenTimeView()
//    }
//}

import SwiftUI
import FamilyControls
import DeviceActivity

struct ScreenTimeView: View {
    let center = AuthorizationCenter.shared
    
    // State properties for Device Activity
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
               of: .day, for: .now
            )!
        ),
        users: .all,
        devices: .init([.iPhone, .iPad])
    )

    var body: some View {
        ZStack {
            // Your UI content here
//            Text("Hello, World!")
            ZStack {
                        // 2 will do next logic - add
                    DeviceActivityReport(context, filter: filter)
            }
        }
        .onAppear {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                    
                    // Here you would typically use DeviceActivity module methods or types to interact with device activity data
                    // For example:
                    // let deviceActivityData = try await DeviceActivity.someMethodToFetchData(context: context, filter: filter)
                    
                } catch {
                    print("Failed to fetch device activity data with error: \(error)")
                }
            }
        }
    }
}

struct ScreenTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTimeView()
    }
}
