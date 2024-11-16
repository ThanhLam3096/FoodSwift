//
//  PriceRangeCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import UIKit

class PriceRangeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var priceRangeButton: UIButton!
    
    //MARK: - NSLayoutConstraint
    @IBOutlet private weak var widthOfpriceRangeButtonButtonConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: PriceRangeCollectionViewCellVM? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    private func setUpUI() {
        widthOfpriceRangeButtonButtonConstraint.constant = ScreenSize.scaleHeight(64)
        priceRangeButton.layer.cornerRadius = ScreenSize.scaleHeight(32)
        priceRangeButton.layer.borderWidth = 1
        priceRangeButton.layer.borderColor = Color.bodyTextColor.withAlphaComponent(0.3).cgColor
        priceRangeButton.setAttributedTitle(NSAttributedString(string: "$", attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.mainColor,
        ]), for: .normal)
    }
    
    private func updateView() {
        guard let priceRange = viewModel?.priceRange else {return}
        priceRangeButton.setAttributedTitle(NSAttributedString(string: priceRange, attributes: [
            .font: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) as Any,
            .foregroundColor: Color.mainColor,
        ]), for: .normal)
    }
}
