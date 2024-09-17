//
//  PageStackView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 16/8/24.
//

import UIKit

class PageStackView: UIView {
    @IBOutlet private weak var pageStackView: UIView!
    @IBOutlet private var pageOneView: UIView!
    @IBOutlet private var pageTwoView: UIView!
    @IBOutlet private var pageThreeView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("PageStackView", owner: self, options: nil)
        self.addSubview(pageStackView)
        pageStackView.frame = self.bounds
        pageStackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        let views: [UIView] = [pageOneView, pageTwoView, pageThreeView]
        for view in views {
            view.layer.cornerRadius = 2
            view.frame.size = CGSize(width: 8.0, height: 5.0)
        }
    }
    
    func setUpColorPageView(numberPage: Int) {
        let views: [UIView] = [pageOneView, pageTwoView, pageThreeView]
        if views.indices.contains(numberPage) {
            views[numberPage].backgroundColor = UIColor.systemGreen
        }
    }
}
