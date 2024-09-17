//
//  TopVericallyTextLabel.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 3/9/24.
//

import UIKit

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        guard let text = self.text else {
            super.drawText(in: rect)
            return
        }
        
        // Tính toán chiều cao của văn bản
        let textSize = (text as NSString).boundingRect(
            with: CGSize(width: rect.width, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self.font!],
            context: nil).size
        
        // Thiết lập một khung mới với chiều cao đã được tính toán
        var newRect = rect
        newRect.size.height = textSize.height
        
        // Vẽ văn bản trong khung mới
        super.drawText(in: newRect)
    }
}
