//
//  SearchRecentTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 17/11/24.
//

import UIKit

class SearchRecentTableViewCell: UITableViewCell {
    
    // MARK: -IBOulet
    @IBOutlet private weak var searchImageView: UIImageView!
    @IBOutlet private weak var contentSearchLabel: UILabel!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet weak var widthOfImageSearchConstraint: NSLayoutConstraint!
    
    // MARK: -Properties
    var viewModel: SearchRecentTableViewCellVM? {
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
//        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.image = UIImage(systemName: "clock.arrow.circlepath")
        searchImageView.tintColor = Color.mainColor
        widthOfImageSearchConstraint.constant = ScreenSize.scaleHeight(24)
        setUpTextTitleFontTextColorOfLabel(label: contentSearchLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
    }
    
    private func updateView() {
        guard let contentSearch = viewModel?.contentSearch else {return}
        contentSearchLabel.text = contentSearch
    }
    
}
