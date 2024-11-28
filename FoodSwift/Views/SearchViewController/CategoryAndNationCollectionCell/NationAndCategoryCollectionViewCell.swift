//
//  NationAndCategoryCollectionViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 14/11/24.
//

import UIKit

final class NationAndCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var mealNationOrCategoryImageView: UIImageView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var mealNationOrCategoryLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: NationAndCategoryCollectionCellVM? {
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
        shadowView.backgroundColor = Color.mainColor.withAlphaComponent(0.5)
        setUpTextTitleFontTextColorOfLabel(label: mealNationOrCategoryLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bgColor)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        mealNationOrCategoryImageView.image = UIImage(named: viewModel.image)
        mealNationOrCategoryLabel.text = viewModel.title
    }
}
