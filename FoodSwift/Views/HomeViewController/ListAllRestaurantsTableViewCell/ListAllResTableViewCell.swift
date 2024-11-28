//
//  ListAllResTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 14/10/24.
//

import UIKit

class ListAllResTableViewCell: UITableViewCell {

    //MARK: - IBOulet
    @IBOutlet private weak var restaurantImageView: UIImageView!
    @IBOutlet private weak var nameResLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var branch1Label: UILabel!
    @IBOutlet private weak var branch2Label: UILabel!
    @IBOutlet private weak var typeFoodLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var numberVoteLabel: UILabel!
    @IBOutlet private weak var timeShipLabel: UILabel!
    @IBOutlet private weak var feeShipLabel: UILabel!
    
    //MARK: - NSLayoutConstraint
    @IBOutlet weak var heightOfRestaurantImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var botSpaceOfRestaurantImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var botSpaceOfNameRestaurantLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var botSpaceOfpriceLabelConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: ListAllResTableViewCellVM? {
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
        setUpImageRestaurant()
        setUpLabel()
    }
    
    private func setUpImageRestaurant() {
        restaurantImageView.layer.cornerRadius = 6
        heightOfRestaurantImageConstraint.constant = ScreenSize.scaleHeight(185)
        botSpaceOfRestaurantImageConstraint.constant = ScreenSize.scaleHeight(15)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameResLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(20)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        botSpaceOfNameRestaurantLabelConstraint.constant = ScreenSize.scaleHeight(10)
        
        setUpTextTitleFontTextColorOfLabel(label: priceLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        botSpaceOfpriceLabelConstraint.constant = ScreenSize.scaleHeight(10)
        
        setUpTextTitleFontTextColorOfLabel(label: branch1Label, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: branch2Label, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: typeFoodLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpTextTitleFontTextColorOfLabel(label: ratingLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: numberVoteLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: timeShipLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: feeShipLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
    }
    
    private func updateView() {
        guard let restaurant = viewModel?.restaurant, let urlImage = URL(string: restaurant.image) else { return }
        nameResLabel.text = restaurant.name
        priceLabel.text = "\(Int(restaurant.averagePrice))$"
        branch1Label.text = restaurant.branch1
        branch2Label.text = restaurant.branch2
        typeFoodLabel.text = restaurant.typeFood
        ratingLabel.text = restaurant.rating
        numberVoteLabel.text = restaurant.numberRating
        timeShipLabel.text = restaurant.time
        feeShipLabel.text = restaurant.feeDelivery
        ImageLoader.shared().loadImageWithFadeIn(url: urlImage, imageView: restaurantImageView)
    }
}
