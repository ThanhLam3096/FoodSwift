//
//  BaseViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties
    var keyboardObserver: KeyboardObserver?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpData()
    }

    func setUpUI() { }
    
    func setUpData() { }
    
    func setUpTextTitleFontTextColorOfLabel(label: UILabel,text: String , labelFont: UIFont, labelTextColor: UIColor) {
        label.text = text
        label.font = labelFont
        label.textColor = labelTextColor
    }
}
