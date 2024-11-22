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
        restaurantImageView.layer.cornerRadius = 6
        
        setUpLabel(label: nameResLabel, labelFont: UIFont.fontYugothicLight(ofSize: 20) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpLabel(label: priceLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpLabel(label: branch1Label, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpLabel(label: branch2Label, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpLabel(label: typeFoodLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.bodyTextColor)
        setUpLabel(label: ratingLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpLabel(label: numberVoteLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpLabel(label: timeShipLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
        setUpLabel(label: feeShipLabel, labelFont: UIFont.fontYugothicLight(ofSize: 12) ?? UIFont.systemFont(ofSize: 17), labelTextColor: Color.mainColor)
    }
    
    private func setUpLabel(label: UILabel, labelFont: UIFont, labelTextColor: UIColor) {
        label.font = labelFont
        label.textColor = labelTextColor
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
