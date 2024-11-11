//
//  UIView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/11/24.
//

import UIKit

extension UIView {
    func setUpTextTitleFontTextColorOfLabel(label: UILabel,text: String = "" , labelFont: UIFont, labelTextColor: UIColor) {
        label.text = text
        label.font = labelFont
        label.textColor = labelTextColor
    }
}
