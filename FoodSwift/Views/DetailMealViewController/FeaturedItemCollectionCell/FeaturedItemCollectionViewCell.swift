//
//  FeaturedItemCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import UIKit

class FeaturedItemCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var imageMealImageView: UIImageView!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var nationMealLabel: UILabel!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var heightOfImageMealConstarint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfNameMealConstarint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfImageMealConstarint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: FeaturedItemCollectionCellVM? {
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
        setUpLabel()
        imageMealImageView.contentMode = .scaleAspectFill
        imageMealImageView.layer.cornerRadius = 6
        heightOfImageMealConstarint.constant = ScreenSize.scaleHeight(140)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        topSpaceOfNameMealConstarint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfImageMealConstarint.constant = ScreenSize.scaleHeight(5)
        
        setUpTextTitleFontTextColorOfLabel(label: priceMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: nationMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal else { return }
        imageMealImageView.sd_setImage(with: URL(string: meal.image))
        nameMealLabel.text = meal.name
        priceMealLabel.text = meal.feeShip == 0 ? "Free" : "\(displayNumber(meal.feeShip))$"
        nationMealLabel.text = meal.nation1
    }

}
