//
//  NotificationListView.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/20/24.
//

import SwiftUI

struct NotificationListView: View {
    var body: some View {
        VStack {
            if let notifications = GlobalConstants.KeyValues.pushNotifications, !notifications.isEmpty {
                List {
                    ForEach(notifications, id: \.self) { notification in
                        VStack(alignment: .leading) {
                            Text(notification.title ?? "")
                                .font(.headline)
                            Text(notification.body ?? "")
                                .font(.subheadline)
                        }.padding(.vertical, 8)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Colors.backgroundColor)
                .navigationTitle("Notifications")
            } else {
                VStack {
                    Text("No notifications available")
                        .foregroundColor(.gray)
                }
        
                .navigationTitle("Notifications")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.backgroundColor)
    }
}


#Preview {
    NotificationListView()
}
