//
//  CustomPageControl.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 10/10/24.
//

import UIKit

class CustomPageControl: UIPageControl {
    
    var dotSize: CGSize = CGSize(width: 8, height: 8) // Kích thước của dot
    var currentDotSize: CGSize = CGSize(width: 12, height: 12) // Kích thước của dot hiện tại
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let totalWidth = (dotSize.width * CGFloat(numberOfPages)) + (CGFloat(numberOfPages - 1) * 8) // Khoảng cách giữa các dot
        let startX = (self.bounds.width - totalWidth) / 2
        
        for i in 0..<numberOfPages {
            let dotFrame: CGRect
            
//             Kiểm tra nếu đây là dot hiện tại
            if i == currentPage {
                dotFrame = CGRect(x: startX + CGFloat(i) * (dotSize.width + 8),
                                  y: (self.bounds.height - currentDotSize.height) / 2,
                                  width: 20,
                                  height: 20)
            } else {
                dotFrame = CGRect(x: startX + CGFloat(i) * (dotSize.width + 8),
                                  y: (self.bounds.height - dotSize.height) / 2,
                                  width: 12,
                                  height: 12)
            }
            
            // Tạo và thêm dot vào pageControl
            let dot = UIView(frame: dotFrame)
//            dot.layer.cornerRadius = dotFrame.height / 2 // Làm tròn các dot
            dot.backgroundColor = (i == currentPage) ? currentPageIndicatorTintColor : pageIndicatorTintColor
            self.addSubview(dot)
        }
    }
}
