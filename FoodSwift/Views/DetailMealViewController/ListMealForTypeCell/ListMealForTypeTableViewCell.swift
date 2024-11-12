//
//  ListMealForTypeTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 24/10/24.
//

import UIKit

class ListMealForTypeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageMealImageView: UIImageView!
    @IBOutlet private weak var lineView: UIView!
    
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var feeShipMealLabel: UILabel!
    @IBOutlet private weak var countryMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var widthOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfImageMealConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: ListMealForTypeTableViewCellVM? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpUI() {
        setUpLabel()
        setUpImageMeal()
        lineView.backgroundColor = UIColor(hex: "#C4C4C4")
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(18)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: infoLabel,text: "Something Info Meal At Here =)" ,labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: feeShipMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: countryMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: priceMealLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.activeColor)
    }
    
    private func setUpImageMeal() {
        imageMealImageView.layer.cornerRadius = 6
        imageMealImageView.contentMode = .scaleAspectFit
        widthOfImageMealConstraint.constant = ScreenSize.scaleWidth(110)
        topSpaceOfImageMealConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceOfImageMealConstraint.constant = ScreenSize.scaleHeight(20)
        leadingSpaceOfImageMealConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateView() {
        guard let mealByCategory = viewModel?.mealByCategory, let urlImage = URL(string: mealByCategory.imageMeal) else { return }
        ImageLoader.shared().loadImageWithSkeleton(url: urlImage, into: imageMealImageView)
        nameMealLabel.text = mealByCategory.nameMeal
        feeShipMealLabel.text = displayNumber(viewModel?.randomDecimal() ?? 1.0)
        countryMealLabel.text = "American"
        priceMealLabel.text = "AUD$\(displayNumber(viewModel?.randomDecimal() ?? 1.0))"
    }
}
