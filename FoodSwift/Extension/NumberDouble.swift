//
//  NumberDouble.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 25/10/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
