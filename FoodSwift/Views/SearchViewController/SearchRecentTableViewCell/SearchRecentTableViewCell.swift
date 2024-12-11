//
//  SearchRecentTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 17/11/24.
//

import UIKit

protocol SearchRecentTableViewCellDelegate: AnyObject {
    func tappingContentViewCell(view: SearchRecentTableViewCell, keySearch: String)
}

final class SearchRecentTableViewCell: UITableViewCell {
    
    // MARK: -IBOulet
    @IBOutlet private weak var contentViewCell: UIView!
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
    weak var delegate: SearchRecentTableViewCellDelegate?

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
        handleContentViewCell()
    }
    
    private func handleContentViewCell() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        contentViewCell.addGestureRecognizer(tapGesture)
        contentViewCell.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let delegate = delegate, let contentSearch = viewModel?.contentSearch {
            delegate.tappingContentViewCell(view: self, keySearch: contentSearch)
        }
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.view?.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
        } else if gesture.state == .ended {
            gesture.view?.backgroundColor = UIColor.clear
        }
    }
    
    private func updateView() {
        guard let contentSearch = viewModel?.contentSearch else {return}
        contentSearchLabel.text = contentSearch
    }
    
}
