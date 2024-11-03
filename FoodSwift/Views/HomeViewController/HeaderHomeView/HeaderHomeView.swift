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
        deliveryLabel.text = "Delivery to"
        deliveryLabel.textColor = Color.activeColor
        deliveryLabel.font = UIFont.fontYugothicLight(ofSize: 12)
        filterLabel.text = "Filter"
        filterLabel.font = UIFont.fontYugothicUIRegular(ofSize: 16)
        filterButton.setImage(UIImage(named: "back_down"), for: .normal)
        filterButton.setAttributedTitle(NSAttributedString(string: "New York, USA", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 20) as Any, .foregroundColor: Color.mainColor
        ]), for: .normal)
        filterButton.semanticContentAttribute = .forceRightToLeft
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        filterButton.setAttributedTitle(NSAttributedString(string: viewModel.location, attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 20) as Any, .foregroundColor: Color.mainColor
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
