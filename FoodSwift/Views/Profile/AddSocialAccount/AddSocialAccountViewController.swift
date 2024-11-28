//
//  AddSocialAccountViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import UIKit

final class AddSocialAccountViewController: BaseViewController {
    
    // MARK: -IBOulet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var facebookSocialButton: SocialButtonView!
    @IBOutlet private weak var googleSocialButton: SocialButtonView!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet private weak var topSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightOfSocialButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfSocialButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfSocialButtonViewConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpLabel()
        setLayoutConstraintOfLabel()
        setUpSocialButtonView()
        setLayoutConstraintOfSocialButtonView()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Add Social Accounts"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(16))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Add social accounts", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: contentLabel, text: "Add your social accounts for more security.\nYou will go directly to their site.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center    
    }
    
    private func setLayoutConstraintOfLabel() {
        topSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(80)
        botSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(24)
    }
    
    private func setUpSocialButtonView() {
        facebookSocialButton.viewModel = SocialButtonViewVM(socialType: .facebook)
        googleSocialButton.viewModel = SocialButtonViewVM(socialType: .google)
    }
    
    private func setLayoutConstraintOfSocialButtonView() {
        heightOfSocialButtonViewConstraint.constant = ScreenSize.scaleHeight(44)
        leadingSpaceOfSocialButtonViewConstraint.constant = ScreenSize.scaleWidth(20)
        trailingSpaceOfSocialButtonViewConstraint.constant = ScreenSize.scaleWidth(20)
    }

}

extension AddSocialAccountViewController {
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
