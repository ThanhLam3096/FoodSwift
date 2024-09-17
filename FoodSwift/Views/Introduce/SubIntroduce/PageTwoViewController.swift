//
//  PageTwoViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageTwoViewController: BaseViewController {
    
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var sologanTitleLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet weak var welcomeButtonView: OrangeButtonView!
    @IBOutlet weak var heightStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var widthStartButtonView: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        logoFoodImageView.image = UIImage(named: "logo_tamano")
        titleLabel.text = "Tamang \nFoodService"
        titleLabel.textColor = UIColor.black
        deliveryLabel.text = "Free delivery offers"
        sologanTitleLabel.text = "Free delivery for new customers via Apple Pay and others payment methods."
        sologanTitleLabel.widthAnchor.constraint(equalToConstant: 312 / 375 * ScreenSize.screenWidth).isActive = true
        sologanTitleLabel.heightAnchor.constraint(equalToConstant: 40 / 812 * ScreenSize.screenHeight).isActive = true
        sologanTitleLabel.numberOfLines = 0
        sologanTitleLabel.textColor = UIColor(hex: "#868686")
        setUpPageView()
        setUpUIWelcomeButtonView() 
    }
    
    private func setUpPageView() {
        pageView.setUpColorPageView(numberPage: 1)
    }
    
    private func setUpUIWelcomeButtonView() {
        widthStartButtonView.constant = 335 / 375 * ScreenSize.screenWidth
        heightStartButtonView.constant = 48 / 812 * ScreenSize.screenHeight
        welcomeButtonView.delegate = self
    }
}

extension PageTwoViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageThree, animated: true)
    }
}
