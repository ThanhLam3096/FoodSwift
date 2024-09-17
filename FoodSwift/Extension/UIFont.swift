//
//  UIFont.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 22/8/24.
//

import Foundation
import UIKit

extension UIFont {
    
    static func hiraginoSansW3(ofSize size: CGFloat) -> UIFont? {
            return UIFont(name: "HiraginoSans-W3", size: size)
    }
    
    static func hiraginoSansW5(ofSize size: CGFloat) -> UIFont? {
            return UIFont(name: "HiraginoSans-W5", size: size)
    }
    
    static func hiraginoSansW6(ofSize size: CGFloat) -> UIFont? {
            return UIFont(name: "HiraginoSans-W6", size: size)
    }
    
    static func fontYugothicLight(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "YuGothic-Light", size: size)
    }
    
    static func fontYugothicRegular(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "YuGothic", size: size)
    }
    
    static func fontYugothicUISemiBold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "YuGothicUI-Semibold", size: size)
    }
    
    static func fontYugothicUIBold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "YuGothicUI-Bold", size: size)
    }
}
