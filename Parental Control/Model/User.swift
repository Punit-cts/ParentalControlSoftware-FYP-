//
//  User.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/20/24.
//

import Foundation

// MARK: - User
struct User: Codable {
    var email: String?
    var isParent: Bool?
    var name: String?
}
