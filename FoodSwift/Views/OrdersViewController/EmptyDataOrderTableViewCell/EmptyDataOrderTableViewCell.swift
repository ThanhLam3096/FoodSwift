//
//  EmptyDataOrderTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 6/12/24.
//

import UIKit

class EmptyDataOrderTableViewCell: UITableViewCell {
    
    // MARK: - IBOulet
    @IBOutlet private weak var emptyOrderImageView: UIImageView!
    
    // MARK: - NSLayoutConstraint
    @IBOutlet private weak var leadingSpaceOfContentView: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfContentView: NSLayoutConstraint!

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
        emptyOrderImageView.image = UIImage(named: "NotFound")
        emptyOrderImageView.layer.cornerRadius = 6
        setUpNSLayoutConstraint()
    }
    
    private func setUpNSLayoutConstraint() {
        leadingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfContentView.constant = ScreenSize.scaleWidth(20)
    }
    
}
