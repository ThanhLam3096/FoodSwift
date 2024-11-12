//
//  FeaturedPartnersCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/10/24.
//

import UIKit
import SDWebImage

protocol FeaturedPartnersCollectionViewCellViewDelegate {
    func didTapImage(in cell: FeaturedPartnersCollectionViewCell, typeList: TypeList)
}

final class FeaturedPartnersCollectionViewCell: UICollectionViewCell {

    //MARK: - @IBOutlet
    @IBOutlet private weak var featuredPartnersImageView: UIImageView!
    @IBOutlet private weak var imageButton: UIButton!
    @IBOutlet private weak var nameFoodLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var ratingFoodLabel: UILabel!
    @IBOutlet private weak var timeShipLabel: UILabel!
    @IBOutlet private weak var feeShipLabel: UILabel!
    @IBOutlet private weak var cricleView: CircleGrayView!
    
    //MARK: - NSLayoutConstraint
    @IBOutlet private weak var heightOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceNameMealLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceAddressMealLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthRatingLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightRatingLabelConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: FeaturedPartnersCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    var delegate: FeaturedPartnersCollectionViewCellViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpViewCell()
    }
    
    private func setUpViewCell() {
        featuredPartnersImageView.layer.cornerRadius = 4
        
        imageButton.setTitle("", for: .normal)
        setUpLabel()
        setUpImageMeal()
    }
    
    private func setUpImageMeal() {
        heightOfImageMealConstraint.constant = ScreenSize.scaleHeight(160)
        botSpaceImageMealConstraint.constant = ScreenSize.scaleHeight(10)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameFoodLabel, text: "", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(20)) ?? UIFont.systemFont(ofSize: 20), labelTextColor: Color.mainColor)
        botSpaceNameMealLabelConstraint.constant = ScreenSize.scaleHeight(5)
        
        setUpTextTitleFontTextColorOfLabel(label: addressLabel, text: "", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        botSpaceAddressMealLabelConstraint.constant = ScreenSize.scaleHeight(5)
        
        setUpTextTitleFontTextColorOfLabel(label: ratingFoodLabel, text: "", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bgColor)
        ratingFoodLabel.backgroundColor = Color.activeColor
        ratingFoodLabel.layer.cornerRadius = 4
        ratingFoodLabel.layer.masksToBounds = true
        ratingFoodLabel.textAlignment = .center
        widthRatingLabelConstraint.constant = ScreenSize.scaleWidth(36)
        heightRatingLabelConstraint.constant = ScreenSize.scaleHeight(20)
        
        setUpTextTitleFontTextColorOfLabel(label: timeShipLabel, text: "", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: feeShipLabel, text: "", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal, let urlImage = URL(string: meal.image) else { return }
        ImageLoader.shared().loadImageWithFadeIn(url: urlImage, imageView: featuredPartnersImageView)
        nameFoodLabel.text = meal.name
        addressLabel.text = meal.address
        ratingFoodLabel.text = meal.rating
        timeShipLabel.text = meal.time
        if meal.feeShip == 0 {
            feeShipLabel.text = "Free delivery"
        } else {
            feeShipLabel.text = "\(displayNumber(meal.feeShip))$"
        }
    }
    
    @IBAction func moveToDetailScreenTouchUpInside(_ sender: Any) {
        if let delegate = delegate, let typeList = viewModel?.typeList {
            delegate.didTapImage(in: self, typeList: typeList)
        }
    }
}
