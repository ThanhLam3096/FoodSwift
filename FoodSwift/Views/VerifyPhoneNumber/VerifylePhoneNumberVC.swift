//
//  VerifylePhoneNumberVC.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 16/9/24.
//

import UIKit

final class VerifylePhoneNumberVC: BaseViewController {
    
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionTextLabel: UILabel!
    @IBOutlet private weak var otpTextField1: UITextField!
    @IBOutlet private weak var otpTextField2: UITextField!
    @IBOutlet private weak var otpTextField3: UITextField!
    @IBOutlet private weak var otpTextField4: UITextField!
    @IBOutlet private weak var continueButtonView: OrangeButtonView!
    @IBOutlet private weak var didntRecevieCodeLabel: UILabel!
    @IBOutlet private weak var sendAgainButton: UIButton!
    @IBOutlet private weak var policyLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        view.backgroundColor = UIColor(hex: "#FBFBFB")
        setUpNavigation()
        setUpLabel()
        
//        sendAgainButton.setTitle("Resend Again", for: .normal)
//        sendAgainButton.setTitleColor(UIColor(hex: "#EEA734"), for: .normal)
//        sendAgainButton.titleLabel?.textColor = UIColor(hex: "#EEA734")
//        sendAgainButton.titleLabel?.font = UIFont.fontYugothicLight(ofSize: 12)
        let attributedSendAgainButton = NSAttributedString(string: "Resend Again", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any,
            .foregroundColor: UIColor(hex: "#EEA734")
        ])
        sendAgainButton.titleLabel?.numberOfLines = 1
        sendAgainButton.titleLabel?.lineBreakMode = .byTruncatingTail
        sendAgainButton.setAttributedTitle(attributedSendAgainButton, for: .normal)
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
        
        didntRecevieCodeLabel.text = "Didn’t receive code?"
        didntRecevieCodeLabel.font = UIFont.fontYugothicLight(ofSize: 12)
        didntRecevieCodeLabel.textColor = UIColor(hex: "#868686")
        
        policyLabel.text = "By Signing up you agree to our Terms\nConditions & Privacy Policy."
        policyLabel.numberOfLines = 0
        policyLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        policyLabel.textColor = UIColor(hex: "#868686")
        policyLabel.textAlignment = .center
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpOrangeButtonView() {
        continueButtonView.delegate = self
        continueButtonView.setButtonTitle("CONTINUE")
    }

}

extension VerifylePhoneNumberVC: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        print("OTP")
    }
}
