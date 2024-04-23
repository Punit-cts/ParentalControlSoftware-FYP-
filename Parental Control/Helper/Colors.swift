//
//  Colors.swift
//  Parental Control
//
//  Created by Amrit Duwal on 4/19/24.
//


import SwiftUI

struct Colors {
    static let backgroundColor =  #colorLiteral(red: 0.81346767070000003, green: 0.99063362880000005, blue: 1, alpha: 1).color
    static let red           = #colorLiteral(red: 0.9176470588, green: 0.2235294118, blue: 0.262745098, alpha: 1).color //EA3943
    static let brown         = #colorLiteral(red: 1, green: 0.7843137255, blue: 0.3411764706, alpha: 1).color //FFC857
    static let brown20       = #colorLiteral(red: 1, green: 0.7843137255, blue: 0.3411764706, alpha: 1).color.opacity(0.2) //FFC857
    static let brown5        = #colorLiteral(red: 1, green: 0.7843137255, blue: 0.3411764706, alpha: 1).color.opacity(0.05) //FFC857
    static let pureWhite     = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).color //ffff
    static let pureBlack     = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).color //0000
    static let darkBlue      = #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.1254901961, alpha: 1).color // 0f1020
    static let darkBlue70    = #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.1254901961, alpha: 1).color.opacity(0.7) // 0f1020
    
    static let lightBrown    = #colorLiteral(red: 0.2470588235, green: 0.2078431373, blue: 0.168627451, alpha: 1).color //3f352b
    static let green         = #colorLiteral(red: 0.462745098, green: 0.8862745098, blue: 0.4078431373, alpha: 1).color //76E268
    
    static let gradient1     = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 1, alpha: 1).color //F7F7FF
    static let blueBorder    = #colorLiteral(red: 0.1450980392, green: 0.1490196078, blue: 0.2980392157, alpha: 1).color //25264c
    
    static let white70       = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).color.opacity(0.7) // F7F7F7, opacity 70%
    static let blue70        = blue.opacity(0.7) // 2E305F, opacity 70%
    static let blue          = #colorLiteral(red: 0.1803921569, green: 0.1882352941, blue: 0.3725490196, alpha: 1).color // 2E305F
    static let darkerGreyColor   = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).color //666666
    static let greenColor        = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.5921568627, alpha: 1).color // 00C897

}

extension UIColor {
    var color: Color {
        Color(uiColor: self)
    }
}


extension Color {
    var uiColor: UIColor {
        UIColor(self)
    }
}
