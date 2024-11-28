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
    
    static func scaleWidth(_ width: CGFloat) -> CGFloat {
        return width * (screenWidth / 375)
    }
    
    static func scaleHeight(_ height: CGFloat) -> CGFloat {
        return height * (screenHeight / 812)
    }
}
