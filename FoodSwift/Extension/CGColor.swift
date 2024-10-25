//
//  CGColor.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 22/10/24.
//

import Foundation
import UIKit

extension CGColor {
    static func hexStringToCGColor(hex: String) -> CGColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Check if the hex string starts with "#", if yes, remove it
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        // Ensure the string is a valid hex color code (6 characters)
        guard cString.count == 6 else {
            return UIColor.gray.cgColor // Return a default color if the input is invalid
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        // Extract RGB components
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        // Return the color as CGColor
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
    }
}
