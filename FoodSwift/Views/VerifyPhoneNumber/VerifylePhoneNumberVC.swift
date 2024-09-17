//
//  VerifylePhoneNumberVC.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 16/9/24.
//

import UIKit

class VerifylePhoneNumberVC: BaseViewController {
    
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        setUpNavigation()
        setUpLabel()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Login To Foodly"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        descriptionTitleLabel.text = "Verify phone number"
        descriptionTitleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 24)
        descriptionTextLabel.textColor = UIColor(hex: "#010F07")
//        Enter the 4-Digit code sent to you at +610489632578
        descriptionTextLabel.text = "Enter the 4-Digit code sent to you at \n+610489632578"
        descriptionTextLabel.textAlignment = .center
        descriptionTextLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        descriptionTextLabel.textColor = UIColor(hex: "#010F07")
        descriptionTextLabel.numberOfLines = 0
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
