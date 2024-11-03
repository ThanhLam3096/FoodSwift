//
//  ListMealForTypeTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 24/10/24.
//

import UIKit

class ListMealForTypeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageMealImageView: UIImageView!
    @IBOutlet private weak var lineView: UIView!
    
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var feeShipMealLabel: UILabel!
    @IBOutlet private weak var countryMealLabel: UILabel!
    @IBOutlet private weak var priceMealLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: ListMealForTypeTableViewCellVM? {
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
        imageMealImageView.layer.cornerRadius = 6
        imageMealImageView.contentMode = .scaleAspectFit
        
        lineView.backgroundColor = UIColor(hex: "#C4C4C4")
        
        setUpLabel(label: nameMealLabel, textFont: UIFont.fontYugothicLight(ofSize: 18) ?? UIFont.systemFont(ofSize: 18), textColor: Color.mainColor)
        setUpLabel(label: infoLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 16) ?? UIFont.systemFont(ofSize: 16), textColor: Color.mainColor)
        setUpLabel(label: feeShipMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), textColor: Color.mainColor)
        setUpLabel(label: countryMealLabel, textFont: UIFont.fontYugothicUIRegular(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), textColor: Color.mainColor)
        setUpLabel(label: priceMealLabel, textFont: UIFont.fontYugothicUISemiBold(ofSize: 14) ?? UIFont.systemFont(ofSize: 14), textColor: Color.activeColor)
    }
    
    private func setUpLabel(label: UILabel, textFont: UIFont, textColor: UIColor) {
        label.font = textFont
        label.textColor = textColor
    }
    
    private func updateView() {
        guard let mealByCategory = viewModel?.mealByCategory, let urlImage = URL(string: mealByCategory.imageMeal) else { return }
        ImageLoader.shared().loadImageWithSkeleton(url: urlImage, into: imageMealImageView)
        nameMealLabel.text = mealByCategory.nameMeal
        feeShipMealLabel.text = displayNumber(viewModel?.randomDecimal() ?? 1.0)
        countryMealLabel.text = "American"
        priceMealLabel.text = "AUD$\(displayNumber(viewModel?.randomDecimal() ?? 1.0))"
    }
}
