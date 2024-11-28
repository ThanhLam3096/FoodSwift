//
//  HeaderHomeView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/10/24.
//

import Foundation
import UIKit

protocol HeaderHomeViewDelegate {
    func tappingInsideList(view: HeaderHomeView)
}

final class HeaderHomeView: UIView {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var headerHomeView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: - @NSLayoutConstraint
    @IBOutlet private weak var topSpaceOfFilterLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOfButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfButtonConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: HeaderHomeVM? {
        didSet {
            updateView()
        }
    }
    var isExpanded = false
    
    var delegate: HeaderHomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUIView()
    }
    
    private func setUpUIView() {
        Bundle.main.loadNibNamed("HeaderHomeView", owner: self, options: nil)
        self.addSubview(headerHomeView)
        headerHomeView.frame = self.bounds
        headerHomeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpLabel()
        setUpButton()
        lineView.backgroundColor = UIColor(hex: "#F6F6F6")
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: deliveryLabel, text: "Delivery to", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.activeColor)
        topSpaceOfFilterLabelConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: filterLabel, text: "Filter", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
    }
    
    private func setUpButton() {
        filterButton.setImage(UIImage(named: "back_down"), for: .normal)
        filterButton.setAttributedTitle(NSAttributedString(string: "New York, USA", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(20)) as Any, .foregroundColor: Color.mainColor
        ]), for: .normal)
        filterButton.semanticContentAttribute = .forceRightToLeft
        trailingSpaceOfButtonConstraint.constant = ScreenSize.scaleWidth(50)
        topSpaceOfButtonConstraint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfButtonConstraint.constant = ScreenSize.scaleHeight(11)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        filterButton.setAttributedTitle(NSAttributedString(string: viewModel.location, attributes: [
            .font: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(20)) as Any, .foregroundColor: Color.mainColor
        ]), for: .normal)
    }
    
    @IBAction func showListLocationButtonTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.tappingInsideList(view: self)
        }
        isExpanded.toggle()
        rotateButtonImage(isExpanded: isExpanded)
    }
    
    func rotateButtonImage(isExpanded: Bool) {
        UIView.animate(withDuration: 0.3) {
            // Nếu isExpanded là true, quay 180 độ; nếu false, trở về trạng thái ban đầu
            self.filterButton.imageView?.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform.identity
        }
    }
    
}
