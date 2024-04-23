////
////  Helper.swift
////  Parental Control
////
////  Created by Amrit Duwal on 4/19/24.
////
//import SwiftUI
//
//struct ActivityIndicator: View {
//    @State private var isAnimating = false
//
//    var body: some View {
//        GeometryReader { geometry in
//            ForEach(0..<6) { index in
//                createDot(at: index, in: geometry)
//                    .frame(width: 10, height: 10)
//                    .rotationEffect(isAnimating ? .degrees(Double(360 * index)) : .degrees(0))
//                    .animation(Animation.linear(duration: 0.6).repeatForever().delay(0.1 * Double(index)))
//            }
//        }
//        .onAppear {
//            isAnimating = true
//        }
//    }
//
//    private func createDot(at index: Int, in geometry: GeometryProxy) -> some View {
//        let angle = 2.0 * .pi / 6.0 * Double(index)
//        let x = cos(angle) * Double(geometry.size.width / 2)
//        let y = sin(angle) * Double(geometry.size.height / 2)
//
//        return Circle()
//            .foregroundColor(.blue)
//            .offset(x: CGFloat(x), y: CGFloat(y))
//    }
//}
//
//// Example Usage:
//// ActivityIndicator()
////     .frame(width: 50, height: 50)
////     .foregroundColor(.blue)
