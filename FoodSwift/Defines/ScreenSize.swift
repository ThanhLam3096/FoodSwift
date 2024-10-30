//
//  ScreenSize.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import Foundation
import UIKit

struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let scaleOfWidth = screenWidth / 375
    static let scaleOfHeight = screenHeight / 812
    
    static func scaleWidth(_ width: CGFloat) -> CGFloat {
        return width * scaleOfWidth
    }
    
    static func scaleHeight(_ height: CGFloat) -> CGFloat {
        return height * scaleOfHeight
    }
}
