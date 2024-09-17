//
//  PageOneViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 11/6/24.
//

import UIKit

class PageOneViewController: BaseViewController {
    @IBOutlet private weak var logoFoodImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var sologanTitleLabel: UILabel!
    @IBOutlet private weak var pageView: PageStackView!
    @IBOutlet weak var welcomeButtonView: WelcomeButtonView!
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
        favoriteLabel.text = "All your favorites"
        sologanTitleLabel.text = "Order from the best local restaurants with easy, on-demand delivery."
        sologanTitleLabel.widthAnchor.constraint(equalToConstant: 312 / 375 * ScreenSize.screenWidth).isActive = true
        sologanTitleLabel.heightAnchor.constraint(equalToConstant: 40 / 812 * ScreenSize.screenHeight).isActive = true
        sologanTitleLabel.numberOfLines = 0
        sologanTitleLabel.textColor = UIColor(hex: "#868686")
        setUpPageView()
        setUpUIWelcomeButtonView()
    }
    
    private func setUpPageView() {
        pageView.setUpColorPageView(numberPage: 0)
    }
    
    private func setUpUIWelcomeButtonView() {
        widthStartButtonView.constant = 335 / 375 * ScreenSize.screenWidth
        heightStartButtonView.constant = 48 / 812 * ScreenSize.screenHeight
        welcomeButtonView.delegate = self
    }
}

extension PageOneViewController: WelcomButtonViewDelegate {
    func tappingInsideButton(view: WelcomeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageTwo, animated: true)
    }
}
