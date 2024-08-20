//
//  UIColor+Hex.swift
//  PapaDuck
//
//  Created by t2024-m0153 on 8/13/24.
//

import UIKit

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    static let colors: [String: String] = [
        "mainYellow": "#FFEE53",
        "subYellow": "#FFFBE6",
        "subBlue" : "#72CBE8",
        "subBlue2" : "#BFCFD4",
        "subBlue3" : "#53B2E8",
        "subBlack" : "#252525",
        "subRed" : "#DD6565"
    ]

    static func color(named name: String) -> UIColor? {
        guard let hexCode = colors[name] else { return nil }
        return UIColor(hexCode: hexCode)
    }

    static var mainYellow: UIColor { return color(named: "mainYellow")! }
    static var subYellow: UIColor { return color(named: "subYellow")! }
    static var subBlue: UIColor { return color(named: "subBlue")! }
    static var subBlue2: UIColor { return color(named: "subBlue2")! }
    static var subBlue3: UIColor { return color(named: "subBlue3")! }
    static var subBlack: UIColor { return color(named: "subBlack")! }
    static var subRed: UIColor { return color(named: "subRed")! }
}
