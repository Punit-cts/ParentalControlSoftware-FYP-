//////
//////  AllAppUses.swift
//////  Parental Control
//////
//////  Created by Amrit Duwal on 4/14/24.
//////
////
////import SwiftUI
////
////struct AllAppUses: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
////
////#Preview {
////    AllAppUses()
////}
//
//
//import SwiftUI
//
//struct AppUsageData {
//    let date: Date
//    let usageTime: Double // in minutes
//}
//
//struct GraphView: View {
//    let appUsageData: [AppUsageData]
//
//    var body: some View {
//        VStack {
//            Text("App Usage Over Time")
//                .font(.title)
//                .padding()
//
//            GeometryReader { geometry in
//                Path { path in
//                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
//
//                    let maxUsage = self.appUsageData.map { $0.usageTime }.max() ?? 1
//                    let scaleFactor = geometry.size.height / CGFloat(maxUsage)
//
//                    for (index, data) in self.appUsageData.enumerated() {
//                        let x = geometry.size.width / CGFloat(self.appUsageData.count - 1) * CGFloat(index)
//                        let y = geometry.size.height - CGFloat(data.usageTime) * scaleFactor
//                        path.addLine(to: CGPoint(x: x, y: y))
//                    }
//                }
//                .stroke(Color.blue, lineWidth: 2)
//            }
//            .frame(height: 200)
//            .padding()
//
//            Text("Date")
//                .font(.caption)
//                .padding(.bottom)
//
//            HStack {
//                ForEach(self.appUsageData, id: \.date) { data in
//                    Text("\(self.dateString(from: data.date))")
//                        .font(.caption)
//                        .padding(.horizontal)
//                }
//            }
//        }
//    }
//
//    func dateString(from date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        return formatter.string(from: date)
//    }
//}
//
