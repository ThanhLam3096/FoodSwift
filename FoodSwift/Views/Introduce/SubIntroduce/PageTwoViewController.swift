//
//  PageTwoViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageTwoViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var deliveryImageView: UIImageView!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var sologanTitleLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet private weak var welcomeButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var widthOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftSpaceOfLogoConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var spaceTopDeliveryImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfDeliveryImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceBottomDeliveryImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceSologanTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var botSpaceSologanTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingSologanTitleLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingSologanTitleLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfPageControlConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfPageControlConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var widthStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var topSpaceOfStartButtonView: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        setUpLabel()
        setUpImageView()
        
        setUpPageView()
        setUpUIWelcomeButtonView() 
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleLabel, text: "Tamang \nFoodService", labelFont: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleWidth(37)) ?? UIFont.systemFont(ofSize: 37), labelTextColor: Color.mainColor)
        
        setLabelFontAndTextColor(label: deliveryLabel, text: "Free delivery offers", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(32)) ?? UIFont.systemFont(ofSize: 32), labelTextColor: Color.mainColor)
        
        setLabelFontAndTextColor(label: sologanTitleLabel, text: "Free delivery for new customers via Apple Pay and others payment methods.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        topSpaceSologanTitleLabelConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceSologanTitleLabelConstraint.constant = ScreenSize.scaleHeight(27.5)
        leadingSologanTitleLabelConstraint.constant = ScreenSize.scaleWidth(30)
        trailingSologanTitleLabelConstraint.constant = ScreenSize.scaleWidth(30)
        sologanTitleLabel.numberOfLines = 0
    }
    
    private func setUpImageView() {
        logoFoodImageView.image = UIImage(named: "logo_tamano")
        widthOfLogoConstraint.constant = ScreenSize.scaleWidth(65)
        topSpaceOfLogoConstraint.constant = ScreenSize.scaleHeight(95)
        leftSpaceOfLogoConstraint.constant = ScreenSize.scaleWidth(20)
        
        deliveryImageView.image = UIImage(named: "deliveryFood")
        widthOfDeliveryImageConstraint.constant = ScreenSize.scaleHeight(264)
        spaceTopDeliveryImageConstraint.constant = ScreenSize.scaleHeight(64)
        spaceBottomDeliveryImageConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpPageView() {
        widthOfPageControlConstraint.constant = ScreenSize.scaleWidth(40)
        heightOfPageControlConstraint.constant = ScreenSize.scaleHeight(5)
        pageView.setUpColorPageView(numberPage: 1)
    }
    
    private func setUpUIWelcomeButtonView() {
        topSpaceOfStartButtonView.constant = ScreenSize.scaleHeight(27.5)
        widthStartButtonView.constant = ScreenSize.scaleWidth(335)
        heightStartButtonView.constant = ScreenSize.scaleHeight(48)
        welcomeButtonView.delegate = self
    }
}

extension PageTwoViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageThree, animated: true)
    }
}
