//
//  ListTableOrderMealTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/11/24.
//

import UIKit

class ListTableOrderMealTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var indexListMealLabel: UILabel!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var totalPriceMeal: UILabel!
    @IBOutlet private weak var intructionsLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: - Constraint
    @IBOutlet private weak var spaceTopOfLineViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOfIntructionViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOfSuperView: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: ListTableOrderMealTableViewCellVM? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUIView()
        setUpFrame()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpUIView() {
        setLabelFontAndTextColor(label: indexListMealLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.accentColor)
        NSLayoutConstraint.activate([
            indexListMealLabel.widthAnchor.constraint(equalToConstant: ScreenSize.scaleWidth(24)),
            intructionsLabel.widthAnchor.constraint(equalToConstant: ScreenSize.scaleWidth(205)),
            intructionsLabel.heightAnchor.constraint(equalToConstant: ScreenSize.scaleHeight(68)),
        ])
        indexListMealLabel.layer.cornerRadius = 4
        indexListMealLabel.layer.borderWidth = 1
        indexListMealLabel.layer.borderColor = CGColor.hexStringToCGColor(hex: "#868686")
        setLabelFontAndTextColor(label: nameMealLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(18)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.mainColor)
        nameMealLabel.textAlignment = .left
        setLabelFontAndTextColor(label: totalPriceMeal, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.accentColor)
        setLabelFontAndTextColor(label: intructionsLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        intructionsLabel.textAlignment = .left
        
        lineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
    }
    
    private func setUpFrame() {
        spaceTopOfIntructionViewConstraint.constant = ScreenSize.scaleHeight(6)
        spaceTopOfLineViewConstraint.constant = ScreenSize.scaleHeight(20)
        spaceTopOfSuperView.constant = ScreenSize.scaleHeight(21)
    }
    
    private func setLabelFontAndTextColor(label: UILabel, labelFont: UIFont, labelTextColor: UIColor) {
        label.font = labelFont
        label.textColor = labelTextColor
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        indexListMealLabel.text = String(viewModel.indexID)
        nameMealLabel.text = viewModel.order.meal.name
        intructionsLabel.text = "Top: \(viewModel.order.topCustom) \nBottom: \(viewModel.order.bottomCustom)"
        totalPriceMeal.text = "Dollars$\(viewModel.summaryPriceMeal())"
    }
    
}
