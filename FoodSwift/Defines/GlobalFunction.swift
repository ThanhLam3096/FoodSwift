//
//  GlobalFunction.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import Foundation
import UIKit
import SDWebImage

func displayNumber(_ number: Double) -> String {
    // Kiểm tra nếu phần thập phân không bằng 0 (số lẻ dạng Double)
    if number.truncatingRemainder(dividingBy: 1) != 0 {
        return String(number)
    } else {
        return String(Int(number))
    }
}
