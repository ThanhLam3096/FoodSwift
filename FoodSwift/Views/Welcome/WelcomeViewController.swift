//
//  WelcomeViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import UIKit

class WelcomeViewController: BaseViewController {

    @IBOutlet private weak var circleTopView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var heightImageView: NSLayoutConstraint!
    @IBOutlet weak var widthImageView: NSLayoutConstraint!
    @IBOutlet private weak var welcomeImageView: UIImageView!
    @IBOutlet private weak var logoImageFoodImageView: UIImageView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet weak var spaceWelcomeImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleWelcomeLabel: UILabel!
    @IBOutlet weak var welcomeButtonView: WelcomeButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIWelcomeButtonView()
    }
    
    override func setUpUI() {
        logoImageFoodImageView.image = UIImage(named: "icon-tamago")
        circleTopView.layer.cornerRadius = 437 / 2
        circleTopView.backgroundColor = UIColor(red: 252/255, green: 247/255, blue: 237/255, alpha: 1.0)
        titleLabel.text = "Tamang \nFoodService"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 37.0)
        titleLabel.textColor = UIColor(red: 138/255, green: 164/255, blue: 189/255, alpha: 1.0)
        let image = UIImage(named: "Welcome-image")
        spaceWelcomeImageConstraint.constant = 212 / 812 * ScreenSize.screenHeight
        welcomeImageView.image = image
        heightImageView.constant = (243 / 812) * ScreenSize.screenHeight
        widthImageView.constant = (213 / 375) * ScreenSize.screenWidth
        welcomeLabel.text = "Welcome"
        titleWelcomeLabel.text = "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!"
        titleWelcomeLabel.widthAnchor.constraint(equalToConstant: 327 / 375 * ScreenSize.screenWidth).isActive = true
        titleWelcomeLabel.heightAnchor.constraint(equalToConstant: 72 / 812 * ScreenSize.screenHeight).isActive = true
    }
    
    private func setUpUIWelcomeButtonView() {
        welcomeButtonView.delegate = self
    }
}

extension WelcomeViewController: WelcomButtonViewDelegate {
    func tappingInsideButton(view: WelcomeButtonView) {
        self.navigationController?.pushViewController(ScreenName.pageOne, animated: true)
    }
}

