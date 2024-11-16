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

struct GlobalVariables {
    static var indexNumber = 0
    static var selectedIndexPath: IndexPath? = IndexPath(item: 0, section: 0)
}

enum HeaderFilterType {
    case nationHeader
    case categoryHeader
    case priceRangeHeader
}
