//
//  AddInstructionTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 4/11/24.
//

import UIKit

class AddInstructionTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var addInstructionButton: UIButton!
    @IBOutlet private weak var addInstructionLabel: UILabel!
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var spaceBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfLabelConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpUIView() {
        addInstructionLabel.font = UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16))
        addInstructionLabel.textColor = Color.mainColor
        addInstructionLabel.text = "Add Special Instructions"
        addInstructionButton.setTitle("", for: .normal)
        heightOfLabelConstraint.constant = ScreenSize.scaleHeight(22)
        
        spaceBottomConstraint.constant = ScreenSize.scaleHeight(14)
        
        lineView.backgroundColor = Color.bodyTextColor.withAlphaComponent(0.3)
    }
}
