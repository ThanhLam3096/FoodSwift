//
//  SignInViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 21/8/24.
//

import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet private weak var titleIntroLabel: UILabel!
    @IBOutlet private weak var title2IntroLabel: UILabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var passwordFormView: TextFieldLoginView!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var signInButtonView: OrangeButtonView!
    @IBOutlet private weak var dontHaveAccountButton: UIButton!
    @IBOutlet private weak var createNewAccountButton: UIButton!
    @IBOutlet private weak var orLabel: UILabel!
    @IBOutlet private weak var googleLoginButton: SocialButtonView!
    @IBOutlet private weak var facebookLoginButton: SocialButtonView!

    // MARK: Constraint
    @IBOutlet weak var leadingOfTitleSuperViewConstrain: NSLayoutConstraint!
    @IBOutlet private weak var spaceOfBetweenTitleConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUI() {
        setUpLabel()
        setUpNavigation()
        
        setUpEmailForm()
        setUpPasswordForm()
        forgotPasswordButton.setAttributedTitle(NSAttributedString(string: "Forget Password?", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any
        ]), for: .normal)
        forgotPasswordButton.titleLabel?.tintColor = Color.bodyTextColor
        dontHaveAccountButton.setAttributedTitle(NSAttributedString(string: "Don't have account?", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any
        ]), for: .normal)
        dontHaveAccountButton.titleLabel?.tintColor = Color.bodyTextColor
        createNewAccountButton.setAttributedTitle(NSAttributedString(string: "Create new account", attributes: [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any
        ]), for: .normal)
        createNewAccountButton.titleLabel?.tintColor = Color.activeColor
        orLabel.text = "Or"
        orLabel.font = UIFont.fontYugothicUIRegular(ofSize: 16)
        orLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        setUpSocialLoginButton()
        signInButtonView.setButtonTitle("SIGN IN")
        signInButtonView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "Sign In"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpLabel() {
        setLabelFontAndTextColor(label: titleIntroLabel, text: "Welcome to Tamang\nFood Services", labelFont: UIFont.fontYugothicUILight(ofSize: ScreenSize.scaleHeight(33)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(33)), labelTextColor: Color.mainColor)
        leadingOfTitleSuperViewConstrain.constant = ScreenSize.scaleHeight(20)
        spaceOfBetweenTitleConstraint.constant = ScreenSize.scaleHeight(20)
        
        setLabelFontAndTextColor(label: title2IntroLabel, text: "Enter your Phone number or Email\naddress for sign in. Enjoy your food :)", labelFont: UIFont.fontYugothicUIRegular(ofSize: ScreenSize.scaleHeight(16)) ?? UIFont.systemFont(ofSize: ScreenSize.scaleHeight(16)), labelTextColor: Color.bodyTextColor)
    }
    
    private func setLabelFontAndTextColor(label: UILabel,text: String , labelFont: UIFont, labelTextColor: UIColor) {
        label.text = text
        label.font = labelFont
        label.textColor = labelTextColor
    }
    
    private func setUpEmailForm() {
        emailFormView.viewModel = TextFieldLoginViewVM(infoTextField: "EMAIL ADDRESS", isPasswordTextField: false)
    }
    
    private func setUpPasswordForm() {
        passwordFormView.viewModel = TextFieldLoginViewVM(infoTextField: "PASSWORD", isPasswordTextField: true)
    }
    
    private func setUpSocialLoginButton() {
        facebookLoginButton.viewModel = SocialButtonViewVM(socialTitle: "facebook", nameIcon: "facebook", titleSocialButton: "CONNECT WITH FACEBOOK")
        googleLoginButton.viewModel = SocialButtonViewVM(socialTitle: "google", nameIcon: "google", titleSocialButton: "CONNECT WITH GOOGLE")
    }
    
    @IBAction func createAccountTouchUpInside(_ sender: Any) {
        self.navigationController?.pushViewController(ScreenName.createAccount, animated: true)
    }
    
    @IBAction func forgotPasswordButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.pushViewController(ScreenName.forgotPassword, animated: true)
    }
    
    @objc func leftAction() {
//        self.navigationController?.popViewController(animated: true)
        print("abcd1234")
    }
}

extension SignInViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.baseTabbar, animated: true)
    }
}
