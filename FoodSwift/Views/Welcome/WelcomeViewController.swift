//
//  WelcomeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import UIKit

class WelcomeViewController: BaseViewController {

    // MARK: IBOutlet
    @IBOutlet private weak var circleTopView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var welcomeImageView: UIImageView!
    @IBOutlet private weak var logoImageFoodImageView: UIImageView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet weak var welcomeButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var widthOfCircleTopViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOutSideCircleTopView: NSLayoutConstraint!
    @IBOutlet private weak var spaceLeftOutSideCircleTopView: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceLeftOfLogoConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var heightImageView: NSLayoutConstraint!
    @IBOutlet private weak var widthImageView: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOfWelcomeImageConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceTitleConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceContentConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingContentConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingContentConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfGetStartButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfGetStartButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfGetStartButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIWelcomeButtonView()
        
    }
    
    override func setUpUI() {
        setUpCirCleTopView()
        setUpImageView()
        setUpLabel()
    }
    
    private func setUpCirCleTopView() {
        widthOfCircleTopViewConstraint.constant = ScreenSize.scaleHeight(437)
        circleTopView.layer.cornerRadius = ScreenSize.scaleHeight(437 / 2)
        circleTopView.backgroundColor = UIColor(hex: "##FCF7ED")
        spaceTopOutSideCircleTopView.constant = -ScreenSize.scaleHeight(49)
        spaceLeftOutSideCircleTopView.constant = -ScreenSize.scaleWidth(101)
    }
    
    private func setUpImageView() {
        logoImageFoodImageView.image = UIImage(named: "icon-tamago")
        widthOfLogoConstraint.constant = ScreenSize.scaleWidth(65)
        spaceTopOfLogoConstraint.constant = ScreenSize.scaleHeight(95)
        spaceLeftOfLogoConstraint.constant = ScreenSize.scaleWidth(20)
        
        let image = UIImage(named: "Welcome-image")
        welcomeImageView.image = image
        spaceTopOfWelcomeImageConstraint.constant = ScreenSize.scaleHeight(64)
        heightImageView.constant = ScreenSize.scaleHeight(243)
        widthImageView.constant = ScreenSize.scaleWidth(213)
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleLabel, text: "Tamang \nFoodService", labelFont: UIFont.fontYugothicUISemiBold(ofSize: ScreenSize.scaleWidth(37)) ?? UIFont.boldSystemFont(ofSize: 37), labelTextColor: Color.bodyTextColor)
        topSpaceTitleConstraint.constant = ScreenSize.scaleHeight(41)
        setLabelFontAndTextColor(label: welcomeLabel, text: "Welcome", labelFont: UIFont.boldSystemFont(ofSize: ScreenSize.scaleHeight(28)), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: contentLabel, text: "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: UIColor(hex: "#3A3A3A"))
        topSpaceContentConstraint.constant = ScreenSize.scaleWidth(20)
        leadingContentConstraint.constant = ScreenSize.scaleWidth(30)
        trailingContentConstraint.constant = ScreenSize.scaleWidth(30)
    }
    
    private func setUpUIWelcomeButtonView() {
        welcomeButtonView.delegate = self
        widthOfGetStartButtonConstraint.constant = ScreenSize.scaleWidth(335)
        heightOfGetStartButtonConstraint.constant = ScreenSize.scaleHeight(48)
        topSpaceOfGetStartButtonConstraint.constant = ScreenSize.scaleHeight(60)
    }
}

extension WelcomeViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageOne, animated: true)
    }
}

