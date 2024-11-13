//
//  SearchCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/11/24.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var nationMealLabel: UILabel!
    @IBOutlet private weak var categoryMealLabel: UILabel!
    
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var heightOfImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfMealImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfMealNameLabelConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: SearchCollectionCellVM? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUICell()
    }
    
    private func setUpUICell() {
        mealImageView.layer.cornerRadius = 6
        setUpLabel()
        setUpNSLayoutConstraint()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: priceMealLabel,text: "$$", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: nationMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: categoryMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
    }
    
    private func setUpNSLayoutConstraint() {
        heightOfImageConstraint.constant = ScreenSize.scaleHeight(140)
        botSpaceOfMealImageConstraint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfMealNameLabelConstraint.constant = ScreenSize.scaleHeight(10)
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal else { return }
        mealImageView.sd_setImage(with: URL(string: meal.imageMeal))
        nameMealLabel.text = meal.nameMeal
        nationMealLabel.text = meal.area
        categoryMealLabel.text = meal.category
    }

}
