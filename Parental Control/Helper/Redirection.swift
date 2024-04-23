//
//  Redirection.swift
//  Book Gara
//
//  Created by Amrit Duwal on 7/9/22.
//

import Combine
import SwiftUI


enum CurrentPage {
    case dashboard
    case UserViews
}

class RedirectionModel: ObservableObject {
    @Published var changeCurrentView: CurrentPage = GlobalConstants.KeyValues.user != nil ? .dashboard : .UserViews
}
