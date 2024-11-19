//
//  ProfileAccoutnSettingHeaderTableView.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 18/11/24.
//

import UIKit

class ProfileAccoutnSettingHeaderTableView: UITableViewHeaderFooterView {

    // MARK: -IBOulet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private var profileAccoutnSettingHeaderTableView: UIView!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet weak var heightOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceOfContentLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingSpaceOfContentLabelConstraint: NSLayoutConstraint!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        self.contentView.addSubview(profileAccoutnSettingHeaderTableView)
        profileAccoutnSettingHeaderTableView.frame = self.bounds
        profileAccoutnSettingHeaderTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setUpUI()
    }
    
    private func setUpUI() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Account Settings", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(28)) ?? UIFont.systemFont(ofSize: 28), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: contentLabel, text: "Update your settings like notifications,\npayments, profile edit etc", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        setUpFrame()
    }
    
    private func setUpFrame() {
        heightOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(30)
        leadingSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleWidth(36)
        trailingSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleWidth(36)
        
        leadingSpaceOfContentLabelConstraint.constant = ScreenSize.scaleWidth(20)
        topSpaceOfContentLabelConstraint.constant = ScreenSize.scaleHeight(5)
    }

}
