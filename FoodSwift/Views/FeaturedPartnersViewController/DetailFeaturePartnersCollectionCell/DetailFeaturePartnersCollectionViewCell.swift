//
//  DetailFeaturePartnersCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/10/24.
//

import UIKit
import SDWebImage

class DetailFeaturePartnersCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageFood: UIImageView!
    @IBOutlet private weak var feeShipImageView: UILabel!
    @IBOutlet private weak var timeShipImageView: UIImageView!
    @IBOutlet private weak var timeShipLabel: UILabel!
    @IBOutlet private weak var feeShipLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameFoodLabel: UILabel!
    @IBOutlet private weak var firstNationLabel: UILabel!
    @IBOutlet private weak var secondNationLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: ListCollectionDetailVM? {
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
        imageFood.layer.cornerRadius = 4
        imageFood.contentMode = .scaleToFill
        imageFood.clipsToBounds = true
        imageFood.frame = contentView.bounds

        
        ratingLabel.backgroundColor = UIColor(hex: "#EEA734")
        ratingLabel.layer.cornerRadius = 4
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 12)
        ratingLabel.textColor = UIColor.white
        
        setUpLabel(label: nameFoodLabel, font: UIFont.fontYugothicLight(ofSize: 20) ?? UIFont.systemFont(ofSize: 20), textColor: UIColor(hex: "#010F07"))
        setUpLabel(label: timeShipLabel, font: UIFont.fontYugothicRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 20), textColor: UIColor(hex: "#FFFFFF"))
        setUpLabel(label: feeShipLabel, font: UIFont.fontYugothicRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 20), textColor: UIColor(hex: "#FFFFFF"))
        setUpLabel(label: firstNationLabel, font: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 20), textColor: UIColor(hex: "#868686"))
        setUpLabel(label: secondNationLabel, font: UIFont.fontYugothicRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 20), textColor: UIColor(hex: "#868686"))
    }
    
    private func setUpLabel(label: UILabel, font: UIFont, textColor: UIColor) {
        label.font = font
        label.textColor = textColor
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal else { return }
        imageFood.sd_setImage(with: URL(string: meal.image))
        timeShipLabel.text = meal.time
        feeShipLabel.text = "\(meal.fee)$"
        ratingLabel.text = meal.rating
        nameFoodLabel.text = meal.name
        firstNationLabel.text = meal.nation1
        secondNationLabel.text = meal.nation2
    }

}
