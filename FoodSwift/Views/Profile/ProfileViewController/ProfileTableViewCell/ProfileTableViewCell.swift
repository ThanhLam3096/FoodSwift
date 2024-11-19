//
//  ProfileTableViewCell.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: -IBOulet
    @IBOutlet private weak var profileItemImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var rightArrowButton: UIButton!
    @IBOutlet private weak var switchButtonSwitch: UISwitch!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet private weak var widthOfProfileIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfProfileIconConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfProfileIconConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfAccountSettingViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfContentLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var centenVeticallyTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfArrowButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfSwitchButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var trailingSpaceOfSuperViewConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    var viewModel: ProfileTableViewCellVM? {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        centenVeticallyTitleLabelConstraint.priority = UILayoutPriority(750)
        topSpaceOfTitleLabelConstraint.priority = UILayoutPriority(1000)
    }
    
    private func setUpUI() {
        setUpLabel()
        setUpButton()
        setUpFrameView()
        profileItemImage.contentMode = .scaleAspectFit
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: contentLabel, labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(14)) ?? UIFont.systemFont(ofSize: 14), labelTextColor: Color.mainColor)
    }
    
    private func setUpButton() {
        switchButtonSwitch.isHidden = true
        switchButtonSwitch.onTintColor = Color.activeColor
        rightArrowButton.tintColor = Color.bodyTextColor
    }
    
    private func setUpFrameView() {
        heightOfAccountSettingViewConstraint.constant = ScreenSize.scaleHeight(72)
        
        widthOfProfileIconConstraint.constant = ScreenSize.scaleHeight(24)
        leadingSpaceOfProfileIconConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfProfileIconConstraint.constant = ScreenSize.scaleWidth(16)
        
        topSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(12)
        botSpaceOfContentLabelConstraint.constant = ScreenSize.scaleHeight(12)
        heightOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(20)
        
        heightOfArrowButtonConstraint.constant = ScreenSize.scaleHeight(24)
        widthOfSwitchButtonConstraint.constant = ScreenSize.scaleWidth(46)
        
        trailingSpaceOfSuperViewConstraint.constant = ScreenSize.scaleWidth(20)
    }
    
    private func updateView() {
        guard let vm = viewModel else { return }
        titleLabel.text = vm.title
        contentLabel.text = vm.content
        if vm.title == "Rate Us" {
            profileItemImage.tintColor = Color.activeColor
        } else {
            profileItemImage.tintColor = Color.bodyTextColor
        }
        
        switch vm.title {
        case "Rate Us":
            profileItemImage.tintColor = Color.activeColor
        case "Logout":
            centenVeticallyTitleLabelConstraint.priority = UILayoutPriority(1000)
            topSpaceOfTitleLabelConstraint.priority = UILayoutPriority(750)
        default:
            profileItemImage.tintColor = Color.bodyTextColor
        }
        
        if vm.isIconSystem {
            profileItemImage.image = UIImage(systemName: vm.image)
        } else {
            profileItemImage.image = UIImage(named: vm.image)
        }
        if vm.switchButton {
            switchButtonSwitch.isHidden = false
            rightArrowButton.isHidden = true
        } else {
            switchButtonSwitch.isHidden = true
            rightArrowButton.isHidden = false
        }
    }
}
