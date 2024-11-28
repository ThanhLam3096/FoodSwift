//
//  DetailFeaturePartnersCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/10/24.
//

import UIKit
import SDWebImage

protocol DetailFeaturePartnersCollectionCellViewDelegate {
    func didTapImage(in cell: DetailFeaturePartnersCollectionViewCell)
}


final class DetailFeaturePartnersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageFood: UIImageView!
    @IBOutlet private weak var listFeaturedPartnersView: UIView!
    @IBOutlet private weak var feeShipImageView: UILabel!
    @IBOutlet private weak var timeShipImageView: UIImageView!
    @IBOutlet private weak var timeShipLabel: UILabel!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var feeShipLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameFoodLabel: UILabel!
    @IBOutlet private weak var firstNationLabel: UILabel!
    @IBOutlet private weak var secondNationLabel: UILabel!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var heightOfImageMealConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfRatingLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfRatingLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfPriceIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfTimeIconConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOfTimeConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTimeConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfTimeConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var botSpaceOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTimePriceRatingViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTimePriceRatingViewConstraint: NSLayoutConstraint!
    
    
    //MARK: - Properties
    var viewModel: ListCollectionDetailVM? {
        didSet {
            updateView()
        }
    }
    var delegate: DetailFeaturePartnersCollectionCellViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpViewCell()
    }
    
    private func setUpViewCell() {
        imageFood.layer.cornerRadius = 4
        imageFood.contentMode = .scaleAspectFill
        imageFood.clipsToBounds = true
        imageFood.frame = contentView.bounds
        heightOfImageMealConstraint.constant = ScreenSize.scaleHeight(280)
        setUpLabel()
        setUpRatingPriceTimeView()
        detailButton.setTitle("", for: .normal)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameFoodLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(20)) ?? UIFont.systemFont(ofSize: 20), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: timeShipLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bgColor)
        setUpTextTitleFontTextColorOfLabel(label: feeShipLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bgColor)
        setUpTextTitleFontTextColorOfLabel(label: firstNationLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: secondNationLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: ratingLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 12), labelTextColor: Color.bgColor)
        ratingLabel.backgroundColor = Color.activeColor
        ratingLabel.layer.cornerRadius = 4
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textAlignment = .center
        widthOfRatingLabelConstraint.constant = ScreenSize.scaleWidth(36)
        heightOfRatingLabelConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpRatingPriceTimeView() {
        listFeaturedPartnersView.layer.cornerRadius = 4
        listFeaturedPartnersView.backgroundColor = Color.accentColor.withAlphaComponent(0.5)
        heightOfTimePriceRatingViewConstraint.constant = ScreenSize.scaleHeight(60)
        widthOfTimeIconConstraint.constant = ScreenSize.scaleWidth(16)
        widthOfPriceIconConstraint.constant = ScreenSize.scaleWidth(13)
        topSpaceOfTimeConstraint.constant = ScreenSize.scaleHeight(5)
        botSpaceOfTimeConstraint.constant = ScreenSize.scaleHeight(10)
        leadingSpaceOfTimeConstraint.constant = ScreenSize.scaleWidth(10)
        botSpaceOfImageMealConstraint.constant = ScreenSize.scaleHeight(10)
        botSpaceOfTimePriceRatingViewConstraint.constant = ScreenSize.scaleHeight(10)
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal else { return }
        imageFood.sd_setImage(with: URL(string: meal.image))
        timeShipLabel.text = meal.time
        feeShipLabel.text = meal.feeShip == 0 ? "Free" : "\(displayNumber(meal.feeShip))$"
        ratingLabel.text = meal.rating
        nameFoodLabel.text = meal.name
        firstNationLabel.text = meal.nation1
        secondNationLabel.text = meal.nation2
    }
    
    @IBAction func moveToDetailScreenTouchUpInside(_ sender: Any) {
        if let delegate = delegate {
            delegate.didTapImage(in: self)
        }
    }
    
}
