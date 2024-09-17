//
//  PageThreeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageThreeViewController: BaseViewController {
    
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var chooseFoodLabel: UILabel!
    @IBOutlet private weak var sologanTitleLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet weak var welcomeButtonView: OrangeButtonView!
    @IBOutlet weak var heightStartButtonView: NSLayoutConstraint!
    @IBOutlet weak var widthStartButtonView: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func setUpUI() {
        logoFoodImageView.image = UIImage(named: "logo_tamano")
        titleLabel.text = "Tamang \nFoodService"
        titleLabel.textColor = UIColor.black
        chooseFoodLabel.text = "Choose your food"
        sologanTitleLabel.text = "Easily find your type of food craving and you’ll get delivery in wide range."
        sologanTitleLabel.widthAnchor.constraint(equalToConstant: 312 / 375 * ScreenSize.screenWidth).isActive = true
        sologanTitleLabel.heightAnchor.constraint(equalToConstant: 40 / 812 * ScreenSize.screenHeight).isActive = true
        sologanTitleLabel.numberOfLines = 0
        sologanTitleLabel.textColor = UIColor(hex: "#868686")
        setUpPageView()
        setUpUIWelcomeButtonView()
    }
    
    private func setUpPageView() {
        pageView.setUpColorPageView(numberPage: 2)
    }
    
    private func setUpUIWelcomeButtonView() {
        widthStartButtonView.constant = 335 / 375 * ScreenSize.screenWidth
        heightStartButtonView.constant = 48 / 812 * ScreenSize.screenHeight
        welcomeButtonView.delegate = self
    }
}

extension PageThreeViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.signIn, animated: true)
    }
}
