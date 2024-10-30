//
//  FeaturedItemCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/10/24.
//

import UIKit

class FeaturedItemCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var imageMealImageView: UIImageView!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var nationMealLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: FeaturedItemCollectionCellVM? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    private func setUpUI() {
        NSLayoutConstraint.activate([
            imageMealImageView.heightAnchor.constraint(equalToConstant: (140 / 812) * ScreenSize.screenHeight)
        ])
        imageMealImageView.contentMode = .scaleAspectFill
        imageMealImageView.layer.cornerRadius = 6
        setUpLabel(label: nameMealLabel, textFont: UIFont.fontYugothicLight(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.mainColor)
        setUpLabel(label: priceMealLabel, textFont: UIFont.fontYugothicRegular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), textColor: Color.mainColor)
        setUpLabel(label: nationMealLabel, textFont: UIFont.fontYugothicRegular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), textColor: Color.mainColor)
    }
    
    private func setUpLabel(label: UILabel, textFont: UIFont, textColor: UIColor) {
        label.font = textFont
        label.textColor = textColor
    }
    
    private func updateView() {
        guard let meal = viewModel?.meal else { return }
        imageMealImageView.sd_setImage(with: URL(string: meal.image))
        nameMealLabel.text = meal.name
        priceMealLabel.text = meal.feeShip == 0 ? "Free" : "\(displayNumber(meal.feeShip))$"
        nationMealLabel.text = meal.nation1
    }

}
