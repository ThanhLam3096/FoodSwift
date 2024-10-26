//
//  FeaturedPartnersCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 13/10/24.
//

import UIKit
import SDWebImage

class FeaturedPartnersCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOulet
    @IBOutlet private weak var featuredPartnersImageView: UIImageView!
    @IBOutlet private weak var nameFoodLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var ratingFoodLabel: UILabel!
    @IBOutlet private weak var timeShipLabel: UILabel!
    @IBOutlet private weak var feeShipLabel: UILabel!
    @IBOutlet private weak var cricleView: CircleGrayView!
    
    //MARK: - Properties
    var viewModel: FeaturedPartnersCollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpViewCell()
    }
    
    private func setUpViewCell() {
        featuredPartnersImageView.layer.cornerRadius = 4
        
        nameFoodLabel.font = UIFont.fontYugothicLight(ofSize: 20)
        nameFoodLabel.textColor = UIColor(hex: "#010F07")
        
        addressLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        addressLabel.textColor = UIColor(hex: "#868686")
        
        ratingFoodLabel.backgroundColor = UIColor(hex: "#EEA734")
        ratingFoodLabel.layer.cornerRadius = 4
        ratingFoodLabel.layer.masksToBounds = true
        ratingFoodLabel.textAlignment = .center
        ratingFoodLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 12)
        ratingFoodLabel.textColor = UIColor.white
        
        timeShipLabel.font = UIFont.fontYugothicLight(ofSize: 14)
        timeShipLabel.textColor = UIColor(hex: "#010F07")
        
        feeShipLabel.font = UIFont.fontYugothicLight(ofSize: 14)
        feeShipLabel.textColor = UIColor(hex: "#010F07")
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
            feeShipLabel.text = "\(meal.feeShip)$"
        }
    }
}
