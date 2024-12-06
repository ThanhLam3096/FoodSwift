//
//  OrdersTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/12/24.
//

import UIKit

final class OrdersTableViewCell: UITableViewCell {
    
    
    // MARK: - IBOulet
    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var intructionsLabel: UILabel!
    @IBOutlet private weak var typeMealLabel: UILabel!
    @IBOutlet private weak var nationMealLabel: UILabel!
    @IBOutlet private weak var totalPriceMealLabel: UILabel!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var widthOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfImageMealConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfImageMealView: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingSpaceOfContentView: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfContentView: NSLayoutConstraint!
    @IBOutlet private weak var bottomSpaceOfContentView: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: OrdersTableViewCellVM? {
        didSet {
            updateUIView()
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
        mealImageView.layer.cornerRadius = 8
        setUpLabel()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: nameMealLabel, labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(18)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: intructionsLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        intructionsLabel.numberOfLines = 0
        setUpTextTitleFontTextColorOfLabel(label: typeMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: nationMealLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: totalPriceMealLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 18), labelTextColor: Color.activeColor)
    }
    
    private func setUpNSLayoutConstraint() {
        widthOfImageMealConstraint.constant = ScreenSize.scaleHeight(110)
        heightOfImageMealConstraint.constant = ScreenSize.scaleHeight(110)
        trailingSpaceOfImageMealView.constant = ScreenSize.scaleWidth(18)
        
        leadingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
        bottomSpaceOfContentView.constant = ScreenSize.scaleHeight(20)
    }
    
    private func updateUIView() {
        guard let viewModel = viewModel,let urlImage = URL(string: viewModel.orders.meal.image) else { return }
        ImageLoader.shared().loadImageWithSkeleton(url: urlImage, into: mealImageView)
        nameMealLabel.text = viewModel.orders.meal.name
        intructionsLabel.text = "Top: \(viewModel.orders.topCustom) \nBottom: \(viewModel.orders.bottomCustom)"
        typeMealLabel.text = viewModel.orders.meal.typeFood
        nationMealLabel.text = viewModel.orders.meal.nation1
        totalPriceMealLabel.text = viewModel.getTotalPriceMeal()
    }
}
