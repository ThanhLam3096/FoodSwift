//
//  NationAndCategoryFilterCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/11/24.
//

import UIKit

final class NationAndCategoryFilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    // MARK: NSLayoutConstraint
    @IBOutlet private weak var leadingSpaceOfFilterTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOFfilterTitleLabelConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: NationAndCategoryFilterCollectionViewCellVM? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpLabel()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: filterTitleLabel, labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(12)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(12)), labelTextColor: Color.bodyTextColor)
        filterTitleLabel.textAlignment = .center
        leadingSpaceOfFilterTitleLabelConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOFfilterTitleLabelConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateView() {
        guard let title = viewModel?.title else { return }
        filterTitleLabel.text = title
    }
}
