//
//  ChoiceCustomMeaTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 2/11/24.
//

import UIKit

class ChoiceCustomMeaTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var outSideCircleView: UIView!
    @IBOutlet private weak var inSideCircleView: UIView!
    @IBOutlet private weak var selectedButton: UIButton!
    @IBOutlet private weak var customMealLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    
    //MARK: - Properties
    var viewModel: ChoiceCustomMealTableViewCellVM? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUICell()
    }
    
    private func setUpUICell() {
        outSideCircleView.frame.size = CGSize(width: ScreenSize.scaleWidth(24), height: ScreenSize.scaleWidth(24))
        outSideCircleView.layer.borderColor = CGColor.hexStringToCGColor(hex: "#868686")
        outSideCircleView.layer.borderWidth = 0.5
        outSideCircleView.layer.cornerRadius = 12
        outSideCircleView.clipsToBounds = true
        inSideCircleView.frame.size = CGSize(width: ScreenSize.scaleWidth(18), height: ScreenSize.scaleWidth(18))
        inSideCircleView.layer.cornerRadius = 9
        inSideCircleView.clipsToBounds = true
        inSideCircleView.backgroundColor = Color.activeColor
        selectedButton.setTitle("", for: .normal)
        customMealLabel.font = UIFont.fontYugothicUIRegular(ofSize: 16)
        customMealLabel.textColor = Color.mainColor
        lineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        customMealLabel.text = viewModel.infoCustomMeal
    }
    
}
