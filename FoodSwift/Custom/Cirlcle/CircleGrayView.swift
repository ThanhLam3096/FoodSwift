//
//  CircleGrayView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/10/24.
//

import UIKit

class CircleGrayView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // Initializer for Storyboard/XIB use
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.frame.size = CGSize(width: 5, height: 5)
        self.backgroundColor = UIColor(hex: "#868686")
        self.layer.cornerRadius = 2.5
        self.layer.masksToBounds = true
    }
}
