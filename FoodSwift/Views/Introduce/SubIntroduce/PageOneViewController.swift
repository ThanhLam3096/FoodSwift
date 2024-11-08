//
//  PageOneViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageOneViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteMealImageView: UIImageView!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var contentFavoriteLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet private weak var welcomeButtonView: OrangeButtonView!
    
    // MARK: Constraint
    @IBOutlet private weak var widthOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceOfLogoConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leftSpaceOfLogoConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var spaceTopFavoriteImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthOfFavoriteImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var spaceBottomFavoriteImageConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var leadingContentFavoriteLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var trailingContentFavoriteLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topSpaceContentFavoriteLabelConstraint: NSLayoutConstraint!
    @IBOutlet private weak var botSpaceContentFavoriteLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var widthOfPageControlConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightOfPageControlConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var topSpaceOfStartButtonView: NSLayoutConstraint!
    @IBOutlet private weak var heightStartButtonView: NSLayoutConstraint!
    @IBOutlet private weak var widthStartButtonView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func setUpUI() {
        setUpImageView()
        setUpLabel()
        setUpPageView()
        setUpUIWelcomeButtonView()
    }
    
    private func setUpImageView() {
        logoFoodImageView.image = UIImage(named: "logo_tamano")
        widthOfLogoConstraint.constant = ScreenSize.scaleWidth(65)
        topSpaceOfLogoConstraint.constant = ScreenSize.scaleHeight(95)
        leftSpaceOfLogoConstraint.constant = ScreenSize.scaleWidth(20)
        
        favoriteMealImageView.image = UIImage(named: "favoriteFood")
        widthOfFavoriteImageConstraint.constant = ScreenSize.scaleHeight(264)
        spaceTopFavoriteImageConstraint.constant = ScreenSize.scaleHeight(64)
        spaceBottomFavoriteImageConstraint.constant = ScreenSize.scaleHeight(20)
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleLabel, text: "Tamang \nFoodService", labelFont: UIFont.fontYugothicUIBold(ofSize: ScreenSize.scaleWidth(37)) ?? UIFont.systemFont(ofSize: 37), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: favoriteLabel, text: "All your favorites", labelFont: UIFont.fontYugothicLight(ofSize: ScreenSize.scaleHeight(32)) ?? UIFont.systemFont(ofSize: 32), labelTextColor: Color.mainColor)
        setLabelFontAndTextColor(label: contentFavoriteLabel, text: "Order from the best local restaurants with easy, on-demand delivery.", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
        topSpaceContentFavoriteLabelConstraint.constant = ScreenSize.scaleHeight(20)
        botSpaceContentFavoriteLabelConstraint.constant = ScreenSize.scaleHeight(27.5)
        leadingContentFavoriteLabelConstraint.constant = ScreenSize.scaleWidth(30)
        trailingContentFavoriteLabelConstraint.constant = ScreenSize.scaleWidth(30)
        contentFavoriteLabel.numberOfLines = 0
    }
    
    private func setLabelFontAndTextColor(label: UILabel,text: String , labelFont: UIFont, labelTextColor: UIColor) {
        label.text = text
        label.font = labelFont
        label.textColor = labelTextColor
    }
    
    private func setUpPageView() {
        widthOfPageControlConstraint.constant = ScreenSize.scaleWidth(40)
        heightOfPageControlConstraint.constant = ScreenSize.scaleHeight(5)
        pageView.setUpColorPageView(numberPage: 0)
    }
    
    private func setUpUIWelcomeButtonView() {
        topSpaceOfStartButtonView.constant = ScreenSize.scaleHeight(27.5)
        widthStartButtonView.constant = ScreenSize.scaleWidth(335)
        heightStartButtonView.constant = ScreenSize.scaleHeight(48)
        welcomeButtonView.delegate = self
    }
}

extension PageOneViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageTwo, animated: true)
    }
}
