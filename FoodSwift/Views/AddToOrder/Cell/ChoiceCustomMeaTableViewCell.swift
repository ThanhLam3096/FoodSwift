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
    @IBOutlet weak var inSideCircleView: UIView!
    @IBOutlet private weak var customMealLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var widthInSideViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOutSideViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfTopOutSideViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfBottomOutSideViewConstraint: NSLayoutConstraint!
    
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
        widthOutSideViewConstraint.constant = ScreenSize.scaleWidth(24)
        outSideCircleView.layer.borderColor = CGColor.hexStringToCGColor(hex: "#868686")
        outSideCircleView.layer.borderWidth = 0.5
        outSideCircleView.layer.cornerRadius = ScreenSize.scaleWidth(12)
        outSideCircleView.clipsToBounds = true
        widthInSideViewConstraint.constant = ScreenSize.scaleWidth(18)
        inSideCircleView.layer.cornerRadius = ScreenSize.scaleWidth(9)
        inSideCircleView.clipsToBounds = true
        inSideCircleView.backgroundColor = Color.activeColor
        inSideCircleView.isHidden = true
        customMealLabel.font = UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16))
        customMealLabel.textColor = Color.mainColor
        lineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        
        spaceOfTopOutSideViewConstraint.constant = ScreenSize.scaleHeight(14)
        spaceOfBottomOutSideViewConstraint.constant = ScreenSize.scaleHeight(14)
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
