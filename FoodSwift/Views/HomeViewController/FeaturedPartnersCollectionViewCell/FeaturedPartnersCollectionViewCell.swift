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

    //MARK: - IBOulet
    @IBOutlet private weak var featuredPartnersImageView: UIImageView!
    @IBOutlet private weak var imageButton: UIButton!
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
    var delegate: FeaturedPartnersCollectionViewCellViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpViewCell()
    }
    
    private func setUpViewCell() {
        featuredPartnersImageView.layer.cornerRadius = 4
        imageButton.setTitle("", for: .normal)
        
        nameFoodLabel.font = UIFont.fontYugothicLight(ofSize: 20)
        nameFoodLabel.textColor = Color.mainColor
        
        addressLabel.font = UIFont.fontYugothicUIRegular(ofSize: 16)
        addressLabel.textColor = Color.bodyTextColor
        
        ratingFoodLabel.backgroundColor = Color.activeColor
        ratingFoodLabel.layer.cornerRadius = 4
        ratingFoodLabel.layer.masksToBounds = true
        ratingFoodLabel.textAlignment = .center
        ratingFoodLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 12)
        ratingFoodLabel.textColor = UIColor.white
        
        timeShipLabel.font = UIFont.fontYugothicLight(ofSize: 14)
        timeShipLabel.textColor = Color.mainColor
        
        feeShipLabel.font = UIFont.fontYugothicLight(ofSize: 14)
        feeShipLabel.textColor = Color.mainColor
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
    
    @IBAction func moveToDetailScreenTouchUpInside(_ sender: Any) {
        if let delegate = delegate, let typeList = viewModel?.typeList {
            delegate.didTapImage(in: self, typeList: typeList)
        }
    }
}
