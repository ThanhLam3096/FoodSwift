//
//  PriceRangeCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import UIKit

class PriceRangeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var priceRangeLabel: UILabel!
    
    //MARK: - NSLayoutConstraint
    @IBOutlet private weak var widthOfpriceRangeLabelConstraint: NSLayoutConstraint!
    
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
        widthOfpriceRangeLabelConstraint.constant = ScreenSize.scaleHeight(64)
        priceRangeLabel.layer.cornerRadius = ScreenSize.scaleHeight(32)
        priceRangeLabel.textAlignment = .center
        priceRangeLabel.layer.borderWidth = 1
        priceRangeLabel.layer.borderColor = Color.bodyTextColor.withAlphaComponent(0.3).cgColor
        setUpTextTitleFontTextColorOfLabel(label: priceRangeLabel, text: "$", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bodyTextColor)
    }
    
    private func updateView() {
        guard let priceRange = viewModel?.priceRange else {return}
        priceRangeLabel.text = priceRange
    }
}
