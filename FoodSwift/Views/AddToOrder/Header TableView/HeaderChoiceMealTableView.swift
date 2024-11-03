//
//  HeaderChoiceMealTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 3/11/24.
//

import Foundation
import UIKit

final class HeaderChoiceMealTableView: UIView {
    
    // MARK: @IBOutlet
    @IBOutlet private weak var headerCustomChoiceMealTableView: UIView!
    @IBOutlet private weak var titleHeaderLabel: UILabel!
    @IBOutlet private weak var requiredButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("HeaderChoiceMealTableView", owner: self, options: nil)
        self.addSubview(headerCustomChoiceMealTableView)
        headerCustomChoiceMealTableView.frame = self.bounds
        headerCustomChoiceMealTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        titleHeaderLabel.font = UIFont.fontYugothicUILight(ofSize: 20)
        titleHeaderLabel.textColor = Color.mainColor
        
        NSLayoutConstraint.activate([
            requiredButton.widthAnchor.constraint(equalToConstant: ScreenSize.scaleWidth(90)),
            requiredButton.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(32))
        ])
        requiredButton.layer.cornerRadius = 4
        requiredButton.backgroundColor = Color.activeColor.withAlphaComponent(0.3)
        requiredButton.setAttributedTitle(NSAttributedString(string: "REQUIRED", attributes: [
            .font: UIFont.fontYugothicUILight(ofSize: 12) as Any,
            .foregroundColor: Color.accentColor
        ]), for: .normal)
    }
    
    func updateTitleHeaderTableView(title: String) {
        titleHeaderLabel.text = title
    }
}
