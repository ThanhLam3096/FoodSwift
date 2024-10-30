//
//  ForgotPasswordViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 5/9/24.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet private weak var forgotPassTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var emailFormView: TextFieldLoginView!
    @IBOutlet private weak var resetPasswordButtonView: OrangeButtonView!
    
    @IBOutlet private weak var resetEmailView: UIView!
    @IBOutlet private weak var resendEmailTitleLabel: UILabel!
    @IBOutlet private weak var descriptionResendEmailLabel: UILabel!
    @IBOutlet private weak var sendAgainButtonView: OrangeButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUpUI() {
        setUpNavigation()
        forgotPassTitleLabel.text = "Forgot Password"
        forgotPassTitleLabel.textAlignment = NSTextAlignment.left
        forgotPassTitleLabel.numberOfLines = 0
        forgotPassTitleLabel.font = UIFont.fontYugothicLight(ofSize: 34)
        forgotPassTitleLabel.textColor = Color.mainColor
        
        descriptionLabel.text = "Enter your email address and we will\nsend you a reset instructions."
        descriptionLabel.font = UIFont.fontYugothicRegular(ofSize: 16)
        descriptionLabel.textColor = Color.bodyTextColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = NSTextAlignment.left
        
        resendEmailTitleLabel.text = "Reset email sent"
        resendEmailTitleLabel.textAlignment = NSTextAlignment.left
        resendEmailTitleLabel.numberOfLines = 0
        resendEmailTitleLabel.font = UIFont.fontYugothicLight(ofSize: 34)
        resendEmailTitleLabel.textColor = Color.mainColor
        
        descriptionResendEmailLabel.numberOfLines = 0
        let textTitle = "We have sent a instructions email\nto sajin tamang@figma.com.  Having problem?"
        descriptionResendEmailLabel.isUserInteractionEnabled = true
        let attributedStringTextTitle = NSMutableAttributedString(string: textTitle)
        attributedStringTextTitle.addAttribute(.font, value: UIFont.fontYugothicRegular(ofSize: 16) as Any, range: NSRange(location: 0, length: attributedStringTextTitle.length))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.bodyTextColor as Any, range: NSRange(location: 0, length: 60))
        attributedStringTextTitle.addAttribute(.foregroundColor, value: Color.activeColor as Any, range: NSRange(location: 62, length: 15))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel))
        descriptionResendEmailLabel.addGestureRecognizer(tapGesture)
        descriptionResendEmailLabel.attributedText = attributedStringTextTitle
        descriptionResendEmailLabel.sizeToFit()
        setUpUIWelcomeButtonView()
    }
    
    private func setUpNavigation() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = "Forgot Password"
        titleLabel.font = UIFont.fontYugothicUISemiBold(ofSize: 16)
        titleLabel.textColor = .black
        navigationItem.titleView = titleLabel
        let backItem = UIBarButtonItem(image: UIImage(named: "back") , style: .plain, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    override func setUpData() {
        setUpTextField()
        resetPasswordButtonView.setButtonTitle("RESET PASSWORD")
        sendAgainButtonView.setButtonTitle("SEND AGAIN")
    }
    
    private func setUpTextField() {
        emailFormView.viewModel = TextFieldLoginViewVM(infoTextField: "EMAIL ADDRESS", isPasswordTextField: false)
    }
    
    @objc func handleTapOnLabel(gesture: UITapGestureRecognizer) {
        // Get the position of the tap in the label
        let tapLocation = gesture.location(in: descriptionResendEmailLabel)
        
        // Calculate the bounding box for the clickable range
        guard let attributedText = descriptionResendEmailLabel.attributedText else { return }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: descriptionResendEmailLabel.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = descriptionResendEmailLabel.numberOfLines
        textContainer.lineBreakMode = descriptionResendEmailLabel.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let glyphIndex = layoutManager.glyphIndex(for: tapLocation, in: textContainer)
        
        // Check if the tap is within the clickable range
        let clickableRange = (attributedText.string as NSString).range(of: "Having problem?")
//        if NSLocationInRange(glyphIndex, clickableRange) {
        if NSLocationInRange(62, clickableRange) {
            // Perform navigation
            navigateToAnotherScreen()
        }
    }
    
    func navigateToAnotherScreen() {
        // Code to navigate to another screen
        print("Open Some Screen Web link")
        // You can use navigationController?.pushViewController or present() method here
    }
    
    private func setUpUIWelcomeButtonView() {
        resetPasswordButtonView.delegate = self
        sendAgainButtonView.delegate = self
    }
    
    @objc func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordViewController: OrangeButtonViewViewDelegate {
    func tappingInsideButton(view: OrangeButtonView) {
        if resetEmailView.isHidden {
            resetEmailView.isHidden = false
        } else {
            print("Email Already to seen reset your password")
        }
    }

}
