//
//  PageThreeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageThreeViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var orderMealImageView: UIImageView!
    @IBOutlet private weak var chooseFoodLabel: UILabel!
    @IBOutlet private weak var sologanOrderLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet weak var welcomeButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var widthOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftSpaceOfLogoConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfOrderImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopOrderImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceBottomOrderImageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topSpaceSologanOrderLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var botSpaceSologanOrderLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingSologanOrderLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingSologanOrderLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfPageControlConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfPageControlConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var widthStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var topSpaceOfStartButtonView: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func setUpUI() {
        setUpLabel()
        setUpImageView()
        setUpPageView()
        setUpUIWelcomeButtonView()
    }
    
    private func setUpLabel() {
        setUpTextTitleFontTextColorOfLabel(label: titleLabel, text: "Tamang \nFoodService", labelFont: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleWidth(37)) ?? UIFont.systemFont(ofSize: 37), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: chooseFoodLabel, text: "Choose your food", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(32)) ?? UIFont.systemFont(ofSize: 32), labelTextColor: Color.mainColor)
        
        setUpTextTitleFontTextColorOfLabel(label: sologanOrderLabel, text: "Easily find your type of food craving and you’ll get delivery in wide range.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        topSpaceSologanOrderLabelConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceSologanOrderLabelConstraint.constant = ScreenSize.scaleHeight(27.5)
        leadingSologanOrderLabelConstraint.constant = ScreenSize.scaleWidth(30)
        trailingSologanOrderLabelConstraint.constant = ScreenSize.scaleWidth(30)
        sologanOrderLabel.numberOfLines = 0
    }
    
    private func setUpImageView() {
        logoFoodImageView.image = UIImage(named: "logo_tamano")
        widthOfLogoConstraint.constant = ScreenSize.scaleWidth(65)
        topSpaceOfLogoConstraint.constant = ScreenSize.scaleHeight(95)
        leftSpaceOfLogoConstraint.constant = ScreenSize.scaleWidth(20)
        
        orderMealImageView.image = UIImage(named: "choiceFood")
        widthOfOrderImageConstraint.constant = ScreenSize.scaleHeight(264)
        spaceTopOrderImageConstraint.constant = ScreenSize.scaleHeight(64)
        spaceBottomOrderImageConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpPageView() {
        widthOfPageControlConstraint.constant = ScreenSize.scaleWidth(40)
        heightOfPageControlConstraint.constant = ScreenSize.scaleHeight(5)
        pageView.setUpColorPageView(numberPage: 2)
    }
    
    private func setUpUIWelcomeButtonView() {
        topSpaceOfStartButtonView.constant = ScreenSize.scaleHeight(27.5)
        widthStartButtonView.constant = ScreenSize.scaleWidth(335)
        heightStartButtonView.constant = ScreenSize.scaleHeight(48)
        welcomeButtonView.delegate = self
    }
}

extension PageThreeViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.signIn, animated: true)
    }
}
