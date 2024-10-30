//
//  CreateAccountViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 2/9/24.
//

import UIKit

class CreateAccountViewController: BaseViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var title2CreateAccountLabel: TopAlignedLabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var passwordFormView: TextFieldLoginView!
    @IBOutlet private weak var fullNameFormView: TextFieldLoginView!
    @IBOutlet private weak var signUpButtonView: OrangeButtonView!
    @IBOutlet private weak var privacyLabel: UILabel!
    @IBOutlet private weak var orLabel: UILabel!
    @IBOutlet private weak var googleLoginButton: SocialButtonView!
    @IBOutlet private weak var facebookLoginButton: SocialButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setUpUI() {
        setUpNavigation()
        titleLabel.text = "Create Account"
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.fontYugothicLight(ofSize: 34)
        titleLabel.textColor = Color.mainColor
        
        title2CreateAccountLabel.numberOfLines = 0
//        title2CreateAccountLabel.textAlignment = NSTextAlignment.left
//        title2CreateAccountLabel.backgroundColor = .green
        let textTitle = "Enter your Name, Email and Password\nfor sign up.  Already have account?"
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 5
//        paragraphStyle.alignment = .left
        title2CreateAccountLabel.isUserInteractionEnabled = true
        let attributedStringTextTitle = NSMutableAttributedString(string: textTitle)
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicRegular(ofSize: 16) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.bodyTextColor as Any, range: NSRange(location: 0, length: 48))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.activeColor as Any, range: NSRange(location: 50, length: 21))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel))
//        attributedStringTextTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        title2CreateAccountLabel.addGestureRecognizer(tapGesture)
        title2CreateAccountLabel.attributedText = attributedStringTextTitle
        title2CreateAccountLabel.sizeToFit()

        setUpTextField()
        
        signUpButtonView.setButtonTitle("SIGN UP")
        
        privacyLabel.text = "By Signing up you agree to our Terms\nConditions & Privacy Policy."
        privacyLabel.textAlignment = .center
        privacyLabel.numberOfLines = 0
        privacyLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        privacyLabel.textColor = Color.bodyTextColor
        
        orLabel.text = "Or"
        orLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        orLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        setUpSocialLoginButton()
        signUpButtonView.delegate = self
    }
    
    private func setUpTextField() {
        fullNameFormView.viewModel = TextFieldLoginViewVM(infoTextField: "FULL NAME", isPasswordTextField: false)
        emailFormView.viewModel = TextFieldLoginViewVM(infoTextField: "EMAIL ADDRESS", isPasswordTextField: false)
        passwordFormView.viewModel = TextFieldLoginViewVM(infoTextField: "PASSWORD", isPasswordTextField: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 16)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func setUpSocialLoginButton() {
        facebookLoginButton.viewModel = SocialButtonViewVM(socialTitle: "facebook", nameIcon: "facebook", titleSocialButton: "CONNECT WITH FACEBOOK")
        googleLoginButton.viewModel = SocialButtonViewVM(socialTitle: "google", nameIcon: "google", titleSocialButton: "CONNECT WITH GOOGLE")
    }

    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapOnLabel(gesture: UITapGestureRecognizer) {
        // Get the position of the tap in the label
        let tapLocation = gesture.location(in: title2CreateAccountLabel)
        
        // Calculate the bounding box for the clickable range
        guard let attributedText = title2CreateAccountLabel.attributedText else { return }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: title2CreateAccountLabel.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = title2CreateAccountLabel.numberOfLines
        textContainer.lineBreakMode = title2CreateAccountLabel.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let glyphIndex = layoutManager.glyphIndex(for: tapLocation, in: textContainer)
        
        // Check if the tap is within the clickable range
        let clickableRange = (attributedText.string as NSString).range(of: "Already have account?")
        if NSLocationInRange(glyphIndex, clickableRange) {
            // Perform navigation
            navigateToAnotherScreen()
        }
    }
    
    func navigateToAnotherScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateAccountViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        self.navigationController?.pushViewController(ScreenName.definePhoneNumber, animated: true)
    }
}
