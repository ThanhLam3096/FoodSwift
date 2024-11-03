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
        
        listFeaturedPartnersView.layer.cornerRadius = 4
        listFeaturedPartnersView.backgroundColor = Color.accentColor.withAlphaComponent(0.5)

        
        ratingLabel.backgroundColor = Color.activeColor
        ratingLabel.layer.cornerRadius = 4
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 12)
        ratingLabel.textColor = UIColor.white
        
        setUpLabel(label: nameFoodLabel, font: UIFont.fontYugothicLight(ofSize: 20) ?? UIFont.systemFont(ofSize: 20), textColor: Color.mainColor)
        setUpLabel(label: timeShipLabel, font: UIFont.fontYugothicUIRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 20), textColor: Color.bgColor)
        setUpLabel(label: feeShipLabel, font: UIFont.fontYugothicUIRegular(ofSize: 12) ?? UIFont.systemFont(ofSize: 20), textColor: Color.bgColor)
        setUpLabel(label: firstNationLabel, font: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 20), textColor: Color.bodyTextColor)
        setUpLabel(label: secondNationLabel, font: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 20), textColor: Color.bodyTextColor)
        
        detailButton.setTitle("", for: .normal)
    }
    
    private func setUpLabel(label: UILabel, font: UIFont, textColor: UIColor) {
        label.font = font
        label.textColor = textColor
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
