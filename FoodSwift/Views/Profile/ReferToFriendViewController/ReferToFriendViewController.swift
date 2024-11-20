//
//  ReferToFriendViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 20/11/24.
//

import UIKit

final class ReferToFriendViewController: BaseViewController {
    
    // MARK: -IBOulet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var shareView: UIView!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var stringShareLabel: UILabel!
    
    // MARK: -NSLayoutConstraint
    @IBOutlet private weak var widthOfCreditCardConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfCreditCardConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfCreditCardConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceOfTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingSpaceOfContentLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingSpaceOfContentLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfShareViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfShareViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfShareViewConstraint: NSLayoutConstraint!
    
    
    @IBOutlet private weak var widthOfShareButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfShareButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSpaceOfShareButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailngSpaceOfShareButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpLayoutConstraintCreditImage()
        setUpLabel()
        setLayoutConstraintOfLabel()
        setUpShareView()
        setUpLayoutConstraintShareView()
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
    
    private func setUpLayoutConstraintCreditImage() {
        widthOfCreditCardConstraint.constant = ScreenSize.scaleWidth(125)
        heightOfCreditCardConstraint.constant = ScreenSize.scaleHeight(123)
        topSpaceOfCreditCardConstraint.constant = ScreenSize.scaleHeight(47)
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Refer a Friend, Get $10", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleHeight(24)) ?? UIFont.systemFont(ofSize: 24), labelTextColor: Color.mainColor)
        setUpTextTitleFontTextColorOfLabel(label: contentLabel, text: "Get $10 in credits when someone sign up using your refer link", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.bodyTextColor)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
    }
    
    private func setLayoutConstraintOfLabel() {
        topSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(30)
        botSpaceOfTitleLabelConstraint.constant = ScreenSize.scaleHeight(25)
        leadingSpaceOfContentLabelConstraint.constant = ScreenSize.scaleWidth(40)
        trailingSpaceOfContentLabelConstraint.constant = ScreenSize.scaleWidth(40)
    }
    
    private func setUpShareView() {
        shareView.layer.cornerRadius = 6
        shareButton.tintColor = Color.mainColor
        
        setUpTextTitleFontTextColorOfLabel(label: stringShareLabel, text: "https://anie.com/6996", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: 16), labelTextColor: Color.mainColor)
    }
    
    private func setUpLayoutConstraintShareView() {
        widthOfShareViewConstraint.constant = ScreenSize.scaleWidth(245)
        heightOfShareViewConstraint.constant = ScreenSize.scaleHeight(44)
        topSpaceOfShareViewConstraint.constant = ScreenSize.scaleHeight(40)
        
        widthOfShareButtonConstraint.constant = ScreenSize.scaleWidth(16)
        heightOfShareButtonConstraint.constant = ScreenSize.scaleHeight(14)
        leadingSpaceOfShareButtonConstraint.constant = ScreenSize.scaleWidth(30)
        trailngSpaceOfShareButtonConstraint.constant = ScreenSize.scaleWidth(20)
    }
}

extension ReferToFriendViewController {
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonTouchUpInside(_ sender: Any) {
        let linkToShare = ["https://anie.com/6996"]
        let activityViewController = UIActivityViewController(activityItems: linkToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
