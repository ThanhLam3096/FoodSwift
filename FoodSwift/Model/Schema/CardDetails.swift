//
//  CardDetails.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 7/12/24.
//

import Foundation

// MARK: - Models
struct CardDetails {
    let number: String
    let expiryMonth: Int
    let expiryYear: Int
    
    var formattedNumber: String {
        var formatted = ""
        for (index, char) in number.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        return formatted
    }
    
    var formattedExpiry: String {
        return String(format: "%02d/%02d", expiryMonth, expiryYear % 100)
    }
}
